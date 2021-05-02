//
//  Events.swift
//  MVVMBindingsBus
//
//  Created by Ndayisenga Jean Claude on 02/05/2021.
//

import Foundation

class Event<T> {
    let identifier: String
    let result: Result<T, Error>?
    
    init(
        identifier: String,
        result: Result<T, Error>?
    ) {
    self.identifier = identifier
    self.result = result
    
    }
    
}
// sub-class of Events

class UserFetchEvent: Event<[User]> {
    
}

// Models

struct User: Codable {
    let name: String
}
