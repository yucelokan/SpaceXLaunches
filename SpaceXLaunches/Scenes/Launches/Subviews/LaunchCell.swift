//
//  LaunchCell.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 21.06.2022.
//

import UIKit

protocol LaunchItem {
    var launchID: String { get }
    var launchMissionName: String { get }
    var launchRocketName: String { get }
    var launchDate: String { get }
}

class LaunchCell: UITableViewCell {
    
    @IBOutlet private weak var rocketLabel: UILabel?
    @IBOutlet private weak var missionLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    
    func configureCell(with item: LaunchItem) {
        missionLabel?.text = item.launchMissionName
        rocketLabel?.text = item.launchRocketName
        dateLabel?.text = item.launchDate
    }
    
}
