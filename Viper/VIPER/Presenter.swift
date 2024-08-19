//
//  Presenter.swift
//  Viper
//
//  Created by Reza Kashkoul on 8/19/24.
//

import Foundation

// Object
// Protocol
// Reference to Interactor, Router, View

//Gule everything together

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func intercatorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: AnyView?
    
    func intercatorDidFetchUsers(with result: Result<[User], any Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    
}

