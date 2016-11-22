//
//  Feed.swift
//  JohoFeed
//
//  Created by alumno on 02/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import Gloss

public struct Feed : Decodable {
    
    public let id : Int?
    public let title : String?
    public let logo : String?
    public let website : String?
    public let articles : [Article]?
    public let language : String?
    public let active : Bool?
    public let imageUrl : String?
    public let createdAt : String?
    public let updatedAt : String?
    
    public init?(json: JSON) {
        id = "id" <~~ json
        title = "title" <~~ json
        logo = "logo" <~~ json
        website = "website" <~~ json
        language = "language" <~~ json
        active = "active" <~~ json
        articles = "Articles" <~~ json
        imageUrl = "image_url" <~~ json
        createdAt = "created_at" <~~ json
        updatedAt = "updated_at" <~~ json
    }
}
