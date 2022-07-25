//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Ivan Potapenko on 25.07.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items:[VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
