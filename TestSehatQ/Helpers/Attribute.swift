//
//  Attribute.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

struct Attribute {
    static var home: String { return "Home" }
    static var news: String { return "News" }
    static var myOrder: String { return "My Order" }
    static var promotion: String { return "Promotion" }
    static var profile: String { return "Profile" }
    static var errorMaintenance: String { return "Server under maintenance!" }
    
}

struct ImageName {
    static var iconHome = UIImage(named: "ic_home")
    static var iconNews = UIImage(named: "ic_news")
    static var iconOrder = UIImage(named: "ic_order")
    static var iconPromo = UIImage(named: "ic_promotion")
    static var iconProfile = UIImage(named: "ic_profile")
    static var iconShare = UIImage(named: "ic_share")
    static var iconVote = UIImage(named: "ic_vote")
    static var iconUnVote = UIImage(named: "ic_unvote")
    static var iconSearch = UIImage(named: "ic_search")
    static var logoSehatQ = UIImage(named: "logo_sehatq")
}

struct Constants {
    static let GOOGLE_CLIENT_ID = "1052104518755-meeu5ngok79tiir4eekpucan4qc1jot7.apps.googleusercontent.com"
}
