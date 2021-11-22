//
//  Cake.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 22/11/21.
//

import Foundation

struct Cake: Codable {
    var title: String?
    var description: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case image
    }
}
