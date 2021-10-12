//
//  ViewController5.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/12.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController5: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        labelDemo2()
    }
    
    func labelDemo1() {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 50, y: 220, width: 200, height: 200)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        view.addSubview(label)
        
        let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        timer
            .map {
                String(format: "%0.2d:%0.2d.%0.2d", arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])
            }.bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func labelDemo2() {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 50, y: 220, width: 200, height: 200)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        view.addSubview(label)
        
        let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        timer
            .map(formatTimeInterval)
            .bind(to: label.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        
        let string = String(format: "%0.2d:%0.2d.%0.2d", arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        
        let attributedString = NSMutableAttributedString(string: string)
        
        //字体
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 16)!, range: NSMakeRange(0, 5))
        //字体颜色
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSMakeRange(0, 5))
        //
        attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributedString
    }
}
