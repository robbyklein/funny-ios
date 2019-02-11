//
//  Networking.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//


import Foundation

class Networking {
    // Make impossible to init
    private init() {}
    
    // Make singleton instance
    static let shared = Networking()
    
    // Json decoder
    let decoder = JSONDecoder()
    
    // Fetch json
    func fetchJson<T:Decodable>(url: String, completion: @escaping (T?, Error?) -> ()) {
        // Create url from string
        guard let url = URL(string: url) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            // Return early if there's an error
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Otherwise if we have our data
            if let data = data {
                do {
                    // Decode the data
                    let json = try JSONDecoder().decode(T.self, from: data)
                    
                    // Call the callback
                    completion(json, nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    func fetchImageData(url: String, completion: @escaping (_ data: Data?, Error?) -> ()) {
        // Create url object
        if let url = URL(string: url) {
            // Start image download
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Image not found
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        completion(nil, "404 Not Found")
                        return
                    }
                }
                
                // Download Error
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                // Success
                if let data = data {
                    completion(data, nil)
                }
            }.resume()
        }
    
    }
}


