//
//  UITableView+Extensions.swift
//  
//
//  Created by okan.yucel on 21.06.2022.
//

import UIKit

public extension UITableView {
    func reload(animation: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            guard animation else {
                self.reloadData()
                return
            }
            UIView.transition(
                with: self, duration: 0.2, options: .transitionCrossDissolve, animations: { [weak self] in
                    self?.reloadData()
                }, completion: nil
            )
        }
    }
    
    func registerNib(_ type: UITableViewCell.Type, bundle: Bundle) {
        register(
            UINib(nibName: type.identifier, bundle: bundle),
            forCellReuseIdentifier: type.identifier
        )
    }

    func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
    
    func showBottomLoader(topSpace: CGFloat = 0, bottomSpace: CGFloat = 48, loadingHeight: CGFloat = 48) {
        DispatchQueue.main.async {
            var animationView = UIActivityIndicatorView(style: .gray)
            if #available(iOS 13.0, *) {
                animationView = UIActivityIndicatorView(style: .large)
            }
            animationView.contentMode = .scaleAspectFit
            animationView.startAnimating()

            let stackView = UIStackView(
                frame: .init(x: 0, y: 0, width: self.bounds.width, height: bottomSpace + loadingHeight)
            )
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: topSpace, left: 0, bottom: bottomSpace, right: 0)
            stackView.alpha = 0.1
            stackView.addArrangedSubview(animationView)
            stackView.heightAnchor.constraint(equalToConstant: bottomSpace + loadingHeight).isActive = true

            self.tableFooterView = stackView
            self.layoutIfNeeded()

            UIView.transition(with: stackView, duration: 0.5, options: [.beginFromCurrentState]) {
                stackView.alpha = 1
            } completion: { _ in }
        }
    }

    func hideBottomLoader() {
        DispatchQueue.main.async {
            UIView.transition(with: self.tableFooterView ?? self, duration: 0.5, options: [.curveEaseOut]) {
                self.tableFooterView?.alpha = 0
                self.layoutIfNeeded()
            } completion: { _ in
                self.tableFooterView = nil
            }
        }
    }
}
