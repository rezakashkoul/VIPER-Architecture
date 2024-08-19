//
//  View.swift
//  Viper
//
//  Created by Reza Kashkoul on 8/19/24.
//

import UIKit

// ViewController
// Protocol
// Reference to Presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var presenter: AnyPresenter?
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with users: [User]) {
        DispatchQueue.main.async { [self] in
            self.users = users
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [self] in
            self.users = []
            label.isHidden = false
            label.text = error
            tableView.isHidden = true
        }
    }
}

//MARK: - TableView Functions:
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
