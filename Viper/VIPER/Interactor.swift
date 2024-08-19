//
//  Interactor.swift
//  Viper
//
//  Created by Reza Kashkoul on 8/19/24.
//

import Foundation

// Object
// Protocol
// Reference to Presenter
// Job: maybe get data or perform some type of interactions and when done go ahead and hand it to Presenter

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getUsers()
}

class UserInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.intercatorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.intercatorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.intercatorDidFetchUsers(with: .failure(error))
            }
        }.resume()
    }
    
}
