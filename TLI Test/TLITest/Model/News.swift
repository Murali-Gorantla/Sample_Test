//
//  News.swift
//  TLI Test
//
//  Created by Murali Gorantla on 22/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import Foundation

struct News: Decodable {
    let url: String?
    let title: String?
    let publishDate: String?
    let byLine: String?
    let abstract: String?
    let media: [Media]?
    
    /**
     * declaring our keys
     **/
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case publishDate = "published_date"
        case byLine = "byline"
        case abstract
        case media
    }
    
    /**
     * defining our (keyed) container
     * extracting the data based on the CodingKey
     * initializing our struct
     **/
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        publishDate = try container.decodeIfPresent(String.self, forKey: .publishDate)
        byLine = try container.decodeIfPresent(String.self, forKey: .byLine)
        abstract = try container.decodeIfPresent(String.self, forKey: .abstract)
        media = try container.decodeIfPresent([Media].self, forKey: .media)
    }
}

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.title == rhs.title
    }
}
