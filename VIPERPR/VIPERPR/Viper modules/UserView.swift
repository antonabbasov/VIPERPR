//
//  View.swift
//  VIPER
//
//  Created by Anton on 23.09.2021.
//

import UIKit
import Foundation

// ViewController
// Reference to presenter
// Protocol
private enum Constants {
    static let userTableViewCellIdentifier = "cell"
}

// MARK: - Protocols

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

final class UserViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Variables
    
    private var users: [User] = []
    
    internal var presenter: AnyPresenter?
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.userTableViewCellIdentifier)
        table.isHidden = true
        return table
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(errorLabel)
        view.addSubview(usersTableView)
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        errorLabel.center = view.center
        errorLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        usersTableView.frame = view.bounds
    }
}

// MARK: - UITableViewDataSource

extension UserViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: Constants.userTableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell 
    }
}

// MARK: - AnyView

extension UserViewController: AnyView {
    
    // MARK: - Instance Methods
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.usersTableView.reloadData()
            self.usersTableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.usersTableView.isHidden = true
            self.errorLabel.text = error
            self.errorLabel.isHidden = false
        }
    }
}
