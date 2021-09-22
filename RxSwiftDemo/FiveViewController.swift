//
//  FiveViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/12.
//

import UIKit
import RxSwift
import RxCocoa

class FiveViewController: UIViewController {

    let disposeBag = DisposeBag()
    let textFieldText = "a"
    let btnTapped = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(self.tgr)
        
        self.textField.frame = CGRect.init(x: 50, y: 100, width: 100, height: 50)
        view.addSubview(textField)
        
        self.button.frame = CGRect.init(x: 50, y: 100+50+10, width: 100, height: 50)
        view.addSubview(button)
        
        self.tgr.rx.event
            .bind(onNext: {[weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        //-
        button.rx.tap
            .map({"Taped!"})
            .bind(to: btnTapped)
            .disposed(by: disposeBag)
        
        btnTapped
            .subscribe({
                print($0.element ?? $0)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func clickTgr() {
        
    }
    
    @objc func clickBtn() {
        
    }
    
    lazy var tgr: UITapGestureRecognizer = {
        let tgr = UITapGestureRecognizer.init(target: self, action: #selector(clickTgr))
        return tgr
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField.init()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "请输入"
        return textField
    }()
    
    lazy var button: Button = {
        let button: Button = Button.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
        button.setTitle("button", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
}
