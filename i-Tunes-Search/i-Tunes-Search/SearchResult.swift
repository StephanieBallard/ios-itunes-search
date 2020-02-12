//
//  SearchResult.swift
//  i-Tunes-Search
//
//  Created by Stephanie Ballard on 2/11/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
