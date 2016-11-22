//
//  Article.swift
//  JohoFeed
//
//  Created by alumno on 02/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import Gloss

public struct Article : Decodable {
    
    public let id : Int?
    public let uId : String?
    public let title : String?
    public let link : String?
    public let imageUrl : String?
    public let description : String?
    public let author : String?
    public let publishDate : String?
    public let feedTitle : String?
    public let createdAt : String?
    public let updatedAt : String?
    
    public init?(json: JSON) {
        id = "id" <~~ json
        uId = "uid" <~~ json
        title = "title" <~~ json
        link = "link" <~~ json
        imageUrl = "image_url" <~~ json
        description = "description" <~~ json
        author = "author" <~~ json
        publishDate = "publish_date" <~~ json
        feedTitle = "feed_title" <~~ json
        createdAt = "created_at" <~~ json
        updatedAt = "updated_at" <~~ json
    }
}
