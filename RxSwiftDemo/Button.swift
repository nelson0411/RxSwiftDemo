//
//  Button.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/12.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 5.0
    }
    
}
