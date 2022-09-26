//
//  LaunchDetailCell.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import UIKit

protocol LaunchDetailItem: LaunchItem {
    var launchMissionImageURL: String { get }
    var launchSuccessMessage: NSAttributedString? { get }
    var launchDetails: String { get }
    var launchSiteName: String { get }
}

class LaunchDetailCell: UITableViewCell {
    
    @IBOutlet private weak var missionImageView: UIImageView?
    @IBOutlet private weak var rocketLabel: UILabel?
    @IBOutlet private weak var missionLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var launchSiteNameLabel: UILabel?
    @IBOutlet private weak var launchSuccesMessageLabel: UILabel?
    @IBOutlet private weak var launchDetailsLabel: UILabel?
    
    func configureCell(with item: LaunchDetailItem) {
        missionLabel?.text = item.launchMissionName
        rocketLabel?.text = item.launchRocketName
        dateLabel?.text = item.launchDate
        launchSiteNameLabel?.text = item.launchSiteName
        launchSuccesMessageLabel?.attributedText = item.launchSuccessMessage
        launchDetailsLabel?.text = item.launchDetails
        
        missionImageView?.load(from: item.launchMissionImageURL, placeholder: "photo.circle")
    }
    
}
