//
//  HistoryCell.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var contentDescLabel: UILabel!
    @IBOutlet weak var contentPriceLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ product: MyOrderProduct) {
        contentDescLabel.text = product.desc
        contentPriceLabel.text = product.price
        contentTitleLabel.text = product.title
        contentImageView.setImage(with: product.imageUrl)
    }
}

extension HistoryCell: ReusableCell {}
