//
//  ProjectsViewController.swift
//  Projects
//
//  Created by David Muzi on 2017-03-06.
//  Copyright © 2017 Muzi. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
    
    let repo: PublicReposQuery.Data.Viewer.Repository.Edge
    
    var projects: [Any]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(repo: PublicReposQuery.Data.Viewer.Repository.Edge) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repo.node!.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let project = projects?[indexPath.row]
        
        //cell.textLabel?.text = project.title
        
        return cell
    }
}
