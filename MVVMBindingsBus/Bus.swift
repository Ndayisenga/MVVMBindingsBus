//
//  Bus.swift
//  MVVMBindingsBus
//
//  Created by Ndayisenga Jean Claude on 02/05/2021.
//

import Foundation

final class Bus {
    static let shared = Bus()
    private init() {}
    
    enum EventType {
        case userFetch
    }
    
    struct Subscription {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[User]>) -> Void)
    }
    private var subscribitions = [Subscription]()
    
    //Subscriptions
    
    func subscribe(
        _ event: EventType,
        block: @escaping ((Event<[User]>) -> Void)
        
        ) {
            let new = Subscription(type: event,
                                   queue: .global(),
                                   block: block)
        subscribitions.append(new)
            
        }
        
        func subscribeOnMain(
            _ event: EventType,
            block: @escaping ((Event<[User]>) -> Void)
        ) {
            let new = Subscription(type: event,
                                   queue: .main,
                                   block: block)
        subscribitions.append(new)
            
    }
    
    
    //Publications
    func publish(type: EventType, event:  UserFetchEvent) {
        let subscribers = subscribitions.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
}
 
