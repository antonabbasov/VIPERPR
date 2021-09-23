//
//  Router.swift
//  VIPER
//
//  Created by Anton on 23.09.2021.
//

import UIKit

// Object
// Entry point for module - there VIPER starts

typealias EntryPoint = AnyView & UIViewController

// MARK: - Protocols

protocol AnyRouter {
    var entryPoint: EntryPoint? { get }
    static func start() -> AnyRouter
}

final class UserRouter {
    
    // MARK: - Variables
    
    internal var entryPoint: EntryPoint?
}

// MARK: - AnyRouter

extension UserRouter: AnyRouter {
    
    // MARK: - Instance Methods
    
    static func start() -> AnyRouter {
        let userRouter = UserRouter()
        
        // Assign VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = userRouter
        presenter.view = view
        userRouter.entryPoint = view as? EntryPoint
        
        return userRouter
    }
}
