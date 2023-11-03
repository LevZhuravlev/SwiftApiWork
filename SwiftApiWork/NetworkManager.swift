//
//  NetworkManager.swift
//  SwiftApiWork
//
//  Created by Журавлев Лев on 03.11.2023.
//

import Foundation

class NetworkManager {
    func getAllPost(complition: @escaping ([Post]) -> ()) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, urlResponse, error in
                guard error == nil else {
                    fatalError("Wrong url")
                }
                
                guard let urlResponse = urlResponse as? HTTPURLResponse,
                    urlResponse.statusCode == 200 else {
                    fatalError("Wrong status code")
                }
                
                guard let data = data else {
                    fatalError("Wrong data")
                }
                
                let posts = try? JSONDecoder().decode([Post].self, from: data)
                complition(posts!)
            }.resume()
        } else {
          fatalError("Wrong url")
        }
    }
}
