//
//  User.swift
//  JohoFeed
//
//  Created by alumno on 02/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import Gloss

public struct User: Decodable {
    
    public let username : String
    public let email : String
    public let password : String
    public let sources : [Feed]?
    public let articles : [Article]?
    public let createdAt : String
    public let updatedAt : String
    
    public init?(json: JSON) {
        username = ("username" <~~ json)!
        email = ("email" <~~ json)!
        password = ("password" <~~ json)!
        sources = "sources" <~~ json
        articles = "articles" <~~ json
        createdAt = ("created_at" <~~ json)!
        updatedAt = ("updated_at" <~~ json)!
    }
}
