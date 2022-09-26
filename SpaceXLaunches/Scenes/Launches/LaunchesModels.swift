//
//  LaunchesModels.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import UIKit
import API
import Extensions

extension Launches.LaunchQueryItem: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(missionName)
        hasher.combine(launchDateLocal)
        hasher.combine(id)
    }
}

extension Launches.LaunchQueryItem: LaunchItem {
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
}

// swiftlint:disable nesting
enum Launches {
    
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Launches.LaunchQueryItem>
    typealias DiffableSnapShot = NSDiffableDataSourceSnapshot<Launches.Section, Launches.LaunchQueryItem>
    typealias LaunchQueryItem = LaunchesQueryQuery.Data.Launch
    
    enum Section {
        case main
    }
    
    enum SubscribeLaunches {
        struct Request { }
        
        struct Response {
            let launches: [Launches.LaunchQueryItem]
        }
        
        struct ViewModel {
            let snapshot: Launches.DiffableSnapShot
        }
    }

    enum FetchLaunches {
        
        struct RequestMore { }
        
        struct Request {
            var offset: Int = 0
            var order: String = LaunchesOrderBy.desc.value
            var sort: String = LaunchesSortBy.date.value
            var status: Status = .available
            
            var query: LaunchesQueryQuery {
                return .init(limit: status.limit, offset: offset, sort: sort, order: order)
            }
        }
        
    }
    
    enum LaunchesSortBy {
        case date
        
        var value: String {
            switch self {
            case .date:
                return "launch_date_local"
            }
        }
    }
    
    enum LaunchesOrderBy {
        case asc
        case desc
        
        var value: String {
            switch self {
            case .asc:
                return "asc"
            case .desc:
                return "desc"
            }
        }
    }
    
    enum Status {
        case fetching
        case available
        case notAvailable

        var limit: Int {
            return 20
        }

        mutating func update(with count: Int?) {
            guard count == limit else {
                self = .notAvailable
                return
            }
            self = .available
        }
    }
    
    enum Loader {
        case footer(Bool)
        case pullToRefresh(Bool)
        
        struct Request {
            
        }
        
        struct Response {
            var loaders: [Loader]
        }
        
        struct ViewModel {
            var loaders: [Loader]
        }
    }
    
    enum Select {

        struct Request {
            var index: Int
        }
        
        struct Response {
            var launch: LaunchQueryItem
        }
        
        struct ViewModel {
            var launch: LaunchQueryItem
        }
    }
    
}
// swiftlint:enable nesting
