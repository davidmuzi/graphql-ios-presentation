//
//  ProjectsViewController.swift
//  Projects
//
//  Created by David Muzi on 2017-03-06.
//  Copyright © 2017 Muzi. All rights reserved.
//

import UIKit
import Apollo

class ProjectsViewController: UITableViewController {
    
    let repo: PublicReposQuery.Data.Viewer.Repository.Edge
    let apollo: ApolloClient
    
    var projects: [RepoProject]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(repo: PublicReposQuery.Data.Viewer.Repository.Edge, apollo: ApolloClient) {
        self.repo = repo
        self.apollo = apollo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repo.node!.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.rightBarButtonItem = button
        
        apollo.fetch(query: ReposProjectsQuery(repo: repo.node!.name)) { result, error in
            
            guard let projects = result?.data?.viewer.repository?.projects.edges as? [ReposProjectsQuery.Data.Viewer.Repository.Project.Edge] else {
                return
            }
            
            self.projects = projects.map { $0.node!.fragments.repoProject }
        }
    }
    
    func add() {
        
        let alert = UIAlertController(title: "Create Project", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            let title = alert.textFields!.first!.text!
            
            let input = CreateProjectInput(ownerId: self.repo.node!.id, name: title)
            let mutation = CreateNewProjectMutation(input: input)
            self.apollo.perform(mutation: mutation) { result, error in
                
                guard let project = result?.data?.createProject?.project.fragments.repoProject else { return }
                self.projects?.append(project)
            }
        }))
        
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let project = projects![indexPath.row]
        
        cell.textLabel?.text = project.name
        
        return cell
    }
}
