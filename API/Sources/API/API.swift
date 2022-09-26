//
//  Networkable.swift
//
//
//  Created by okan.yucel on 21.06.2022.
//

import UIKit
import Apollo

public class API {
    
    private init() { }
    public static let shared = API()
    
    private(set) lazy var apollo: ApolloClient = {
        return ApolloClient(url: getURL(with: ""))
    }()
    
    private func getURL(with trail: String) -> URL {
        guard let url =  URL(string: "\(Bundle.main.infoForKey("API") ?? "")/\(trail)") else {
            fatalError("invalid url")
        }
        return url
    }

    public var isDeveloperMode: Bool = false
    public var clients: [String: Cancellable] = [:]
    
    public func cancelAllClients() {
        clients.forEach { _, client in
            client.cancel()
        }
    }
}
