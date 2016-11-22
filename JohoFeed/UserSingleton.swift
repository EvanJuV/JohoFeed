//
//  UserSingleton.swift
//  JohoFeed
//
//  Created by HAGANE on 11/22/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import Foundation

private var _UserSharedInstance: UserSingleton = UserSingleton()

class UserSingleton {
    var user : User!
    
    class func setup(user: User) {
        _UserSharedInstance = UserSingleton(user: user)
    }
    
    class var sharedInstance: UserSingleton {
        if _UserSharedInstance == nil {
            print("error: shared called before setup")
        }
        
        return _UserSharedInstance
    }
    
    init(user: User) {
        self.user = user
    }
    
    init() {
        
    }
}
