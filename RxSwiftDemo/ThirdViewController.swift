//
//  ThirdViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/11.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController {

    var disposeBag = DisposeBag()
    var nameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.nameField.frame = CGRect.init(x: 50, y: 200, width: 300, height: 50)
        view.addSubview(self.nameField)
        
        self.passWordField.frame = CGRect.init(x: 50, y: 270, width: 300, height: 50)
        view.addSubview(self.passWordField)
        
        self.loginBtn.frame = CGRect.init(x: 50, y: 340, width: 300, height: 50)
        view.addSubview(self.loginBtn)
        
        self.bindTextField()
        self.bindButton()
    }
    
    func bindTextField() {
        self.nameField.rx.text
            .map ({ (s) in
                return s
            })
            .bind(to: self.passWordField.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    func bindButton() {
        self.loginBtn.rx.tap
            .subscribe ({ _ in
                if self.nameField.text != "" {
                    self.nameArray.append(self.nameField.text!)
                    self.nameField.text = ""
                }
                self.passWordField.text = self.nameArray.joined(separator: ",")
            })
            .disposed(by: self.disposeBag)
    }
    
    lazy var nameField: UITextField = {
        let textField = UITextField.init()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "请输入姓名"
        return textField
    }()
    
    lazy var passWordField: UITextField = {
        let textField = UITextField.init()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "请输入密码"
        return textField
    }()
    
    lazy var loginBtn: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        //button.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
        button.setTitle("点击", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
}
