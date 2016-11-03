//
//  Article.swift
//  JohoFeed
//
//  Created by alumno on 02/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import Foundation

public struct Article : Decodable {
    
    public let title : String?
    public let feeds : [Feed]?
    public let createdAt : String?
    public let updatedAt : String?
    
    public init?(json: JSON) {
        title = "title" <~~ json
        feeds = "feeds" <~~ json
        createdAt = "created_at" <~~ json
        updatedAt = "updated_at" <~~ json
    }
}
