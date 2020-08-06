//
//  UIImageView.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String, placeholder: Placeholder? = nil){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource, placeholder: placeholder, options: [.transition(.fade(0.2))])
    }
}
