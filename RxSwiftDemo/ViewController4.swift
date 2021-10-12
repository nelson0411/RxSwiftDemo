//
//  ViewController4.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/11.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController4: UIViewController {

    let disposeBag = DisposeBag()
    
    let label = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        label.frame = CGRect.init(x: 50, y: 220, width: 200, height: 200)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        view.addSubview(label)
        
        demo3()
    }
    
    //buffer
    func demo1() {
        let subject = PublishSubject<String>()
        
//        subject
//            .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
//            .subscribe({ event in
//                print(String(describing: event.element))
//            })
//            .disposed(by: disposeBag)
        
        subject
            .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")

        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
    }
    
    //window
    func demo2() {
        
        let subject = PublishSubject<String>()
        
        subject
            .window(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] value in
                print("subscribe \(value)")
                value.asObservable().subscribe(onNext: {
                    print($0)
                })
                .disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")

        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
    }
    
    //map
    func demo3() {
        let observable = Observable.from([1,2,3])
        observable
            .map({$0 * 10})
            .subscribe({ event in
                print(event)
                //print(event.element ?? event.element)
            })
            .disposed(by: disposeBag)
    }
}
