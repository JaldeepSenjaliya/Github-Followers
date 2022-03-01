//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Jaldeep Patel on 2022-02-14.
//

import Foundation

class NetworkManager {
    
    static let shared  = NetworkManager()
    let baseURL        = "https://api.github.com/users/"
    
    private init() { }
    
    
    func getFollowers(for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endPoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            //completed(nil, .invalidUsername)
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                //completed(nil, .unableToComplete)
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //completed(nil, .invalidResponse)
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                //completed(nil, .invalidData)
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                //completed(followers, nil)
                completed(.success(followers))
            } catch {
                //completed(nil, .invalidData)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
