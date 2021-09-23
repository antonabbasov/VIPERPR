//
//  Presenter.swift
//  VIPER
//
//  Created by Anton on 23.09.2021.
//

import Foundation

// Object
// protocol
// reference to interactor, view and router

enum FetchError: Error {
    case failed
}

// MARK: - Protocols

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactodDidFetchUsers(with result: Result<[User], Error>)
}

final class UserPresenter {
    
    // MARK: - Variables
    
    internal var router: AnyRouter?
    internal var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    // MARK: - UserPresenter initialisation
    
    init() {
        interactor?.getUsers()
    }
}

//MARK: - AnyPresenter

extension UserPresenter: AnyPresenter {
    
    //MARK: - Instance Methods
    
    func interactodDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
}
