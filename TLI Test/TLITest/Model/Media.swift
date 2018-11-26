//
//  Media.swift
//  TLI Test
//
//  Created by Murali Gorantla on 22/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import Foundation

struct Media: Decodable {
    
    let medias: [MediaMetadata]?
    
    private enum CodingKeys: String, CodingKey {
        case medias = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        medias = try container.decodeIfPresent([MediaMetadata].self, forKey: .medias)
    }
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.medias![0].url == rhs.medias![0].url
    }
}

struct MediaMetadata: Decodable {
    let url: String?
    let format: String?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case format
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        format = try container.decodeIfPresent(String.self, forKey: .format)
    }
}

extension MediaMetadata: Equatable {
    static func == (lhs: MediaMetadata, rhs: MediaMetadata) -> Bool {
        return lhs.format == rhs.format
    }
}
