//
//  CategoryCell.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ category: Category) {
        iconImageView.setImage(with: category.imageUrl, placeholder: ImageName.logoSehatQ)
        titleLabel.text = category.name
    }

}

extension CategoryCell: ReusableCell {}
