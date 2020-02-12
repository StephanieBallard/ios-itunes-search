//
//  SearchResultController.swift
//  i-Tunes-Search
//
//  Created by Stephanie Ballard on 2/11/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")
    
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        guard let baseURL = baseURL else { return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTermQueryItem = URLQueryItem( name: "search", value: searchTerm)
        
        urlComponents?.queryItems = [searchTermQueryItem]
        
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
       
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from the data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: itunesSearch.results)
            } catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            completion()
        }
        dataTask.resume()
    }
}
