//
//  Networkable.swift
//  
//
//  Created by okan.yucel on 21.06.2022.
//

import Foundation
import Apollo

public protocol Networkable { }

public extension Networkable {
    func fetchResponse<Query: GraphQLQuery>(
        query: Query, completion: @escaping (Result<Query.Data, Error>) -> Void
    ) {
        Logger.info("Query:\n\(query.operationDefinition)")
        DispatchQueue.global(qos: .userInitiated).async {
            let client = API.shared.apollo.fetch(query: query) { result in
                API.shared.clients.removeValue(forKey: "\(query.operationName)")
                switch result {
                case .success(let response):
                    guard let data = response.data else {
                        let message = response.errors?.compactMap({
                            $0.localizedDescription
                        }).joined(separator: "\n") ?? "no data"
                        DispatchQueue.main.async {
                            completion(.failure(NSError(domain: message, code: -1)))
                        }
                        Logger.info("Error:\n\(message)")
                        return
                    }
                    Logger.info("Response:\n\(data.resultMap.prettyString ?? "")")
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                case .failure(let error):
                    Logger.info("Error:\n\(error)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            API.shared.clients["\(query.operationName)"] = client
        }
    }
}
