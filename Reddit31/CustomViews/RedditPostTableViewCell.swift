//
//  RedditPostTableViewCell.swift
//  Reddit31
//
//  Created by Jon Corn on 1/22/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {

    // MARK: - Properties
    var redditPost: RedditPost? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    // MARK: - Functions
    func updateViews() {
        guard let post = redditPost else { return }
        RedditPostService.fetchImageFor(post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.postImageView.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                self.titleLabel.text = post.title
                self.upvotesLabel.text = "Up votes: \(post.ups)"
                self.commentCountLabel.text = "Comment count: \(post.commentCount)"
            }
        }
    }
}
