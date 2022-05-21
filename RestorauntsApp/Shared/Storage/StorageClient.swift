//
//  StorageClient.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

protocol StorageClientProtocol {
    
    func getRestaurants() -> RestaurantsCodable
    
}

class StorageClient: StorageClientProtocol {
    
    lazy var restaurants: RestaurantsCodable = {
        loadData()
    }()
    
    func getRestaurants() -> RestaurantsCodable {
        restaurants
    }
    
    func loadData() -> RestaurantsCodable {
        let restaurants = readLocalJSON("example")
        return restaurants
    }
    
    private func readLocalJSON(_ name: String) -> RestaurantsCodable {
        let path = URL(
            fileURLWithPath: Bundle.main.path(
                forResource: name,
                ofType: "json"
            ) ?? ""
        )
        do {
            let dataString = try String(contentsOf: path)
            let data = dataString.data(using: .utf8)!
            let result = try JSONDecoder().decode(RestaurantsCodable.self, from: data)
            return result
        } catch {
            fatalError("Failed to open/parse JSON: \(error)")
            
        }
    }
    
}
