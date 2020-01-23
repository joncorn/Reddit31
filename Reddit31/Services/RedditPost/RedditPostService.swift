//
//  RedditPostService.swift
//  Reddit31
//
//  Created by Jon Corn on 1/22/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class RedditPostService {
    
    // MARK: - String Helpers
    static let baseURL = URL(string: "https://www.reddit.com")
    static let rPathComponent = "r"
    static let jsonPathExtension = "json"
    
    // MARK: - Methods
    static func fetchPosts(searchText: String, completion: @escaping (Result<[RedditPost], NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let finalURL = baseURL.appendingPathComponent(rPathComponent).appendingPathComponent(searchText).appendingPathExtension(jsonPathExtension)
        
        URLSessionManager.fetchData(for: finalURL) { (result) in
            switch result {
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    var posts: [RedditPost] = []
                    for dict in topLevel.data.children {
                        let post = dict.data
                        posts.append(post)
                    }
                    completion(.success(posts))
                    
                } catch {
                    print(error, error.localizedDescription)
                    return completion(.failure(.thrownError(error)))
                }
            case .failure(let error):
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }
    }
    
    static func fetchImageFor(_ post: RedditPost, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: post.imageURL) else { return completion(.failure(.invalidURL)) }
        
        URLSessionManager.fetchData(for: url) { (result) in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return completion(.failure(.noData)) }
                completion(.success(image))
            case .failure(let error):
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }
    }
}
