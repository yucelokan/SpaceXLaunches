//
//  LaunchesViewController.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import UIKit
import Extensions

protocol LaunchesDisplayLogic: AnyObject {
    func displaySnapshot(viewModel: Launches.SubscribeLaunches.ViewModel)
    func displayLoader(viewModel: Launches.Loader.ViewModel)
    func displayDetail(viewModel: Launches.Select.ViewModel)
    func displayError(message: String)
}

final class LaunchesViewController: UIViewController, AlertPresentableLogic {
    
    var interactor: LaunchesBusinessLogic?
    var router: (LaunchesRoutingLogic & LaunchesDataPassing)?
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var refreshView: UIRefreshControl = {
        return .init()
    }()
    
    private var dataSource: Launches.DiffableDataSource?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LaunchesInteractor(worker: LaunchesWorker())
        let presenter = LaunchesPresenter()
        let router = LaunchesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        dataSource = Launches.DiffableDataSource(
            tableView: tableView
        ) { (table, indexPath, model) -> UITableViewCell? in
            let cell = table.dequeueCell(type: LaunchCell.self, indexPath: indexPath)
            cell.configureCell(with: model)
            return cell
        }
        
        interactor?.subscribeLaunches(request: .init())
        interactor?.fetchLaunches(request: .init())
    }
    
    private func setupUI() {
        title = "launches".localizeIt
        tableView.delegate = self
        tableView.alwaysBounceVertical = true
        refreshView.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshView
        tableView.registerNib(LaunchCell.self, bundle: .main)
    }
    
    @objc private func pullToRefresh() {
        interactor?.fetchLaunches(request: .init())
    }
    
}

extension LaunchesViewController: LaunchesDisplayLogic {
    func displaySnapshot(viewModel: Launches.SubscribeLaunches.ViewModel) {
        dataSource?.apply(viewModel.snapshot, animatingDifferences: false)
    }
    
    func displayLoader(viewModel: Launches.Loader.ViewModel) {
        viewModel.loaders.forEach { loader in
            switch loader {
            case .footer(let loading):
                loading ? tableView.showBottomLoader() : tableView.hideBottomLoader()
            case .pullToRefresh(let loading):
                DispatchQueue.main.async { [weak refreshView] in
                    loading ? refreshView?.beginRefreshing() : refreshView?.endRefreshing()
                }
            }
        }
    }
    
    func displayDetail(viewModel: Launches.Select.ViewModel) {
        router?.routeToLaunchDetail(viewModel: viewModel)
    }
    
    func displayError(message: String) {
        presentAlert(
            "error".localizeIt, message: message, actionTitle: "okay".localizeIt
        )
    }
}

extension LaunchesViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrolledPosition = scrollView.contentOffset.y + scrollView.frame.size.height
        guard scrollView == tableView,
              scrolledPosition >= scrollView.contentSize.height else { return }
        interactor?.fetchMoreLaunches(request: .init())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.fetchLaunchDetail(request: .init(index: indexPath.row))
    }
}
