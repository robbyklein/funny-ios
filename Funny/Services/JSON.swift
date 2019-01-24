//
//  JSON.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation

class JSON {
    // Make impossible to init
    private init() {}
    
    // Make singleton instance
    static let shared = JSON()
    
    // Json decoder
    let decoder = JSONDecoder()
    
    // Fetch json
    func fetchJson<T:Decodable>(url: String, completion: @escaping (T) -> ()) {
        // Create url from string
        guard let url = URL(string: ApiRoutes.fetchItems) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Return early if there's an error
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Otherwise if we have our data
            if let data = data {
                do {
                    // Decode the data
                    let json = try JSONDecoder().decode(T.self, from: data)
                    
                    // Call the callback
                    completion(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
}
