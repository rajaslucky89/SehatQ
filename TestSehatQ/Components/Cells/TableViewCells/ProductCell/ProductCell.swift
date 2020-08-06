//
//  ProductCell.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import SkeletonView

class ProductCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCell(_ product: Product) {
        showAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.containerView.setCornerRadius(5.0)
            self.productImageView.setImage(with: product.imageUrl, placeholder: ImageName.logoSehatQ)
            self.titleLabel.text = product.title
            self.descLabel.text = product.desc
            self.priceLabel.text = "Price : " + product.price

            //Stop animating skeleton view
            self.hideAnimation()
        }
        
    }
    
    func showAnimation() {
        productImageView.showAnimatedSkeleton()
        [titleLabel, descLabel, priceLabel].forEach { ($0?.showAnimatedSkeleton()) }
    }
    
    func hideAnimation() {
        productImageView.hideSkeleton()
        [titleLabel, descLabel, priceLabel].forEach { ($0?.hideSkeleton()) }
    }
}

extension ProductCell: ReusableCell {}
