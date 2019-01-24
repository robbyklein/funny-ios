//
//  HomeController.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class HomeController: Layout {
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchItems()
    }
    
    func fetchItems() {
        guard let url = URL(string: ApiRoutes.fetchItems) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Items.self, from: data)
                    self.items = json.items
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

