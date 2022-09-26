//
//  LaunchDetailViewController.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import UIKit
import Extensions

protocol LaunchDetailDisplayLogic: AnyObject {
    func displayLaunchDetail(viewModel: LaunchDetail.FetchDetail.ViewModel)
    func displayLoader(viewModel: LaunchDetail.Loader.ViewModel)
    func displayError(message: String)
}

final class LaunchDetailViewController: UIViewController, AlertPresentableLogic {
    
    var interactor: LaunchDetailBusinessLogic?
    var router: (LaunchDetailRoutingLogic & LaunchDetailDataPassing)?
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var refreshView: UIRefreshControl = {
        return .init()
    }()
    
    private var viewModel: LaunchDetail.FetchDetail.ViewModel?
    
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
        let interactor = LaunchDetailInteractor(worker: LaunchDetailWorker())
        let presenter = LaunchDetailPresenter()
        let router = LaunchDetailRouter()
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
        interactor?.fetchLaunch(request: .init())
    }
    
    private func setupUI() {
        title = viewModel?.launch.launchMissionName
        tableView.alwaysBounceVertical = true
        refreshView.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshView
        tableView.registerNib(LaunchDetailCell.self, bundle: .main)
    }
    
    @objc private func pullToRefresh() {
        interactor?.fetchDetail(request: .init())
    }
}

extension LaunchDetailViewController: LaunchDetailDisplayLogic {
    func displayLaunchDetail(viewModel: LaunchDetail.FetchDetail.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.launch.launchMissionName
        tableView.reload()
    }
    
    func displayError(message: String) {
        presentAlert(
            "error".localizeIt, message: message, actionTitle: "okay".localizeIt
        ) { [weak navigationController] in
            navigationController?.popViewController(animated: true)
        }
    }
    
    func displayLoader(viewModel: LaunchDetail.Loader.ViewModel) {
        DispatchQueue.main.async { [weak refreshView] in
            viewModel.loading ? refreshView?.beginRefreshing() : refreshView?.endRefreshing()
        }
    }
}

extension LaunchDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.launch == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueCell(type: LaunchDetailCell.self, indexPath: indexPath)
        cell.configureCell(with: viewModel.launch)
        return cell
    }
}
