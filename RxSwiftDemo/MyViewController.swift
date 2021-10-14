//
//  MyViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/14.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewTitle()
        //print("MyViewController -> viewDidLoad")
    }

}

extension UIViewController {
    func setViewTitle() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.orange,
                                                                   NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25)]
        let str : String = NSStringFromClass(Self.self)
        title = str
        print("setViewTitle()-> \(str)")
    }
}
