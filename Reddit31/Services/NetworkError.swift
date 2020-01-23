//
//  NetworkError.swift
//  Reddit31
//
//  Created by Jon Corn on 1/22/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Could not contact the server"
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .noData:
            return "The server responded with no data"
        }
    }
}
