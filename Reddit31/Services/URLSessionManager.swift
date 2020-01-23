//
//  URLSessionManager.swift
//  Reddit31
//
//  Created by Jon Corn on 1/22/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

class URLSessionManager {
    
    static func fetchData(for url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            completion(.success(data))
            
        }.resume()
    }
}
