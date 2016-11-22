//
//  Category.swift
//  JohoFeed
//
//  Created by alumno on 02/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import Gloss

public struct Category : Decodable {
    
    public let id : Int?
    public let title : String?
    public let feeds : [Feed]?
    public let imageUrl : String?
    public let createdAt : String?
    public let updatedAt : String?
    
    public init?(json: JSON) {
        id = "id" <~~ json
        title = "title" <~~ json
        feeds = "Feeds" <~~ json
        imageUrl = "image_url" <~~ json
        createdAt = "created_at" <~~ json
        updatedAt = "updated_at" <~~ json
    }
}
