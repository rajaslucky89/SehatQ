//
//  DetailProductController.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class DetailProductController: UIViewController {
    @IBOutlet weak var lovedCountLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: DetailProductViewModel!
    
    init(_ viewModel: DetailProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailProductController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
        setRightNavigation()
    }
}

//  MARK: - Set Components
extension DetailProductController {
    private func setComponents() {
        navigationItem.title = viewModel.product.title
        descLabel.text = viewModel.product.desc
        titleLabel.text = viewModel.product.title.capitalized
        priceLabel.text = viewModel.product.price
        lovedCountLabel.text = String(describing: viewModel.product.loved)
        imageView.setImage(with: viewModel.product.imageUrl)
        if viewModel.product.loved == 1 {
            loveButton.setImage(ImageName.iconVote, for: UIControl.State.normal)
        }else{
           loveButton.setImage(ImageName.iconUnVote, for: UIControl.State.normal)
        }
        buyButton.addTarget(self, action: #selector(buyButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc @IBAction func buyButtonPressed(_ sender: UIButton) {
        let order = MyOrderProduct()
        order.id = order.incrementID()
        order.title = viewModel.product.title
        order.desc = viewModel.product.desc
        order.price = viewModel.product.price
        order.loved = viewModel.product.loved
        order.imageUrl = viewModel.product.imageUrl
        MyOrderProduct.create(object: order)
        navigationController?.popViewController(animated: true)
    }
    
    private func setRightNavigation() {
        let rightBarButton = UIBarButtonItem(image: ImageName.iconShare, style: .plain, target: self, action: #selector(showShareSheet))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func showShareSheet() {
        let message = "Raja Syahmudin Harahap - \(NetworkUrl.linkedinRaja)"
        presentShareMessage(message: message)
    }
}
