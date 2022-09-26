//
//  Stubber.swift
//  SpaceXLaunchesTests
//
//  Created by okan.yucel on 23.06.2022.
//

import Foundation
import Apollo

public enum Stubber {
    public static func fetchResponse<Query: GraphQLQuery>(
        fileName: String, query: Query, completion: @escaping (Result<Query.Data, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let path = Bundle(for: EmptyClass.self).path(forResource: fileName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let response = try Query.Data(jsonObject: json ?? [:])
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "no json file", code: 400, userInfo: nil)))
            }
        }
    }
}

private final class EmptyClass {}
