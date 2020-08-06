//
//  ButtonExtender.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class ButtonExtender: UIButton {
    //MARK: PROPERTIES
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var borderShadow: UIColor = UIColor.black {
        didSet {
            layer.shadowColor = borderShadow.cgColor
            layer.shadowOffset = CGSize(width: 0.0, height: self.frame.size.height/2)
            layer.shadowOpacity = 0.8
            layer.masksToBounds = false
            layer.shadowRadius = 12
            let shadowPath = CGRect(x: self.bounds.origin.x + 40,
                                    y: self.bounds.origin.y,
                                    width: self.frame.size.width - 80,
                                    height: self.frame.size.height/2)
            let path = UIBezierPath(rect: shadowPath)
            layer.shadowPath = path.cgPath
        }
    }
    
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
        setup()
        configure()
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        configure()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
    }
    
    func setup() {
        layer.borderWidth = 1.0
        layer.cornerRadius = 1.0
    }
    
    func configure() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.shadowColor = borderShadow.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
