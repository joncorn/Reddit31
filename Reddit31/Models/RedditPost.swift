//
//  RedditPost.swift
//  Reddit31
//
//  Created by Jon Corn on 1/22/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Codable {
    let data: DataLevel
    
    struct DataLevel: Codable {
        let children: [TopLevelPost]
        
        struct TopLevelPost: Codable {
            let data: RedditPost
        }
    }
}

struct RedditPost: Codable {
    let title: String
    let ups: Int
    let commentCount: Int
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case ups
        case commentCount = "num_comments"
        case imageURL = "thumbnail"
    }
}
