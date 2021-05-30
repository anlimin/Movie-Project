//
//  Video.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-14.
//

import Foundation

struct Video: Codable {
    let results: [VideoKey]
}

struct VideoKey: Codable {
    let key: String
    let id: String
}
