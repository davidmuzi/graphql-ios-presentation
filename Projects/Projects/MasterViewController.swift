//
//  MasterViewController.swift
//  Projects
//
//  Created by David Muzi on 2017-03-05.
//  Copyright © 2017 Muzi. All rights reserved.
//

import UIKit
import Apollo

class MasterViewController: UITableViewController {

    var repos: [PublicReposQuery.Data.Viewer.Repository.Edge]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default

        let token = ProcessInfo.processInfo.environment["TOKEN"]!
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData // Create a ticket on Apollo for this
        
        let url = URL(string: "https://api.github.com/graphql")!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apollo.fetch(query: PublicReposQuery()) { result, error in
            
            guard let repos = result?.data?.viewer.repositories.edges as? [PublicReposQuery.Data.Viewer.Repository.Edge] else {
                print("error: \(error)")
                fatalError()
            }
            
            self.repos = repos
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let repo = repos![indexPath.row]
        cell.textLabel!.text = repo.node?.name
        cell.detailTextLabel?.text = "\(repo.node!.projects.edges!.count) projects"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos![indexPath.row]
        let projectController = ProjectsViewController(repo: repo, apollo: apollo)
        show(projectController, sender: self)
    }
}
