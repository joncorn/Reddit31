//
//  RedditPostsTableViewController.swift
//  Reddit31
//
//  Created by Jon Corn on 1/22/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class RedditPostsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var posts: [RedditPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var redditSearchBar: UISearchBar!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        redditSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? RedditPostTableViewCell else { return UITableViewCell()}
        
        let post = posts[indexPath.row]
        cell.redditPost = post

        return cell
    }
}

extension RedditPostsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        RedditPostService.fetchPosts(searchText: searchText) { (result) in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
