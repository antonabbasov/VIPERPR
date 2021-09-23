//
//  Interactor.swift
//  VIPER
//
//  Created by Anton on 23.09.2021.
//

import Foundation

// Object
// protocol
// reference to presenter

// MARK: - Protocols

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

final class UserInteractor {
    
    // MARK: - Variables
    
    internal var presenter: AnyPresenter?
}

// MARK: - AnyInteractor

extension UserInteractor: AnyInteractor {
    
    // MARK: - Instance Methods
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactodDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            do {
                let usersEntities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactodDidFetchUsers(with: .success(usersEntities))
            }
            catch {
                self?.presenter?.interactodDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
