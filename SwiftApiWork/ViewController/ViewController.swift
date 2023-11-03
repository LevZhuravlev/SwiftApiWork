//
//  ViewController.swift
//  SwiftApiWork
//
//  Created by Журавлев Лев on 03.11.2023.
//

import UIKit

// Topics

// - URLSession - networking
// - TableView
// - Closure
// - Многопоточность, как вызывать в главном потоке

class ViewController: UIViewController {
            
    let networkManager = NetworkManager()
    let tableView = UITableView()
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConstraints()
        loadData()
    }
    
    func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func loadData() {
        networkManager.getAllPost { [weak self] posts in
            let _ = posts.map { print($0) }
            DispatchQueue.main.async {
                self?.posts = posts
                self?.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let post = posts[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        return cell
    }
}
