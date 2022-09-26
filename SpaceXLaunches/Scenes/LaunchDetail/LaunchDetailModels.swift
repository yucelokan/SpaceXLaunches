//
//  LaunchDetailModels.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation
import API
import UIKit

extension LaunchDetail.LaunchDetailQueryItem: LaunchDetailItem {
    var launchMissionImageURL: String {
        return links?.missionPatch ?? ""
    }
    
    var launchID: String {
        return id ?? ""
    }
    
    var launchMissionName: String {
        return missionName ?? ""
    }
    
    var launchRocketName: String {
        return (rocket?.rocketName ?? "") + " - " + (rocket?.rocketType ?? "")
    }
    
    var launchDate: String {
        return launchDateLocal?.date(
            from: "yyyy-MM-dd'T'HH:mm:ss-SS:SS", toFormat: "HH:mm - dd MMM, yyyy"
        ) ?? launchDateLocal ?? ""
    }
    
    var launchSuccessMessage: NSAttributedString? {
        guard let isLaunched = launchSuccess else { return nil }
        let message = isLaunched ? "launched_successfully" : "not_launched"
        let messageColor: UIColor = isLaunched ? .systemGreen : .systemRed
        let attributes = [NSAttributedString.Key.foregroundColor: messageColor]
        return NSAttributedString(string: message.localizeIt, attributes: attributes)
    }
    
    var launchDetails: String {
        return details ?? ""
    }
    var launchSiteName: String {
        return launchSite?.siteNameLong ?? ""
    }
}

extension LaunchDetail.LaunchDetailQueryItem {
    init(from: Launches.LaunchQueryItem) {
        self.init()
        self.id = from.id
        self.missionName = from.missionName
        self.rocket = .init(rocketName: from.rocket?.rocketName, rocketType: from.rocket?.rocketType)
        self.launchDateLocal = from.launchDateLocal
    }
}

// swiftlint:disable nesting
enum LaunchDetail {
    
    typealias LaunchDetailQueryItem = LaunchDetailQueryQuery.Data.Launch
    
    enum FetchLaunch {
        
        struct Request {
            
        }
        
    }
    
    enum FetchDetail {
        
        struct Request {
            
        }
        
        struct Response {
            var launch: LaunchDetailQueryQuery.Data.Launch
        }
        
        struct ViewModel {
            var launch: LaunchDetailItem
        }
        
    }
    
    enum Loader {
        
        struct Request {
            
        }
        
        struct Response {
            var loading: Bool
        }
        
        struct ViewModel {
            var loading: Bool
        }
        
    }
    
}
// swiftlint:enable nesting
