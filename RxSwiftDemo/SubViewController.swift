//
//  SubViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/11.
//

import UIKit
import RxSwift
import RxCocoa

class SubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        subject_demo3()
    }
    
    // Observable
    func observable_demo1() {
        let numberSequnce = Observable.just(5)
        let numberSequnceSubscription = numberSequnce.subscribe { (x) in
            print(x)
        }
        
        let numberSequnceSubscription2 = numberSequnce.subscribe { (x) in
            switch x {
            case .next(let a):
                print("next = \(a)")
            case .error(let e):
                print("error = \(e)")
            case .completed:
                print("completed")
            }
        }
    }
    
    func observable_demo2() {
        let helloSequence = Observable.from(["A","B","C","D"])
        let helloSequenceSubscription = helloSequence.subscribe { (event) in
            switch event {
            case .next(let s):
                print("next = \(s)")
            case .error(let e):
                print("error = \(e)")
            case .completed:
                print("completed")
            }
        }
    }
    
    func observable_demo3() {
        _ = Observable<String>.create({ (observableOfString) -> Disposable in
            
            observableOfString.on(.next("A"))
            observableOfString.onNext("B")
            observableOfString.onCompleted()
            
            return Disposables.create {
                print("Disposable")
            }
        }).subscribe({
            print($0)
        })
    }
    
    func observable_demo4() {
        _ = Observable<Any>.create({ (observableOfAny) -> Disposable in
            observableOfAny.onNext("A")
            observableOfAny.onNext(["B","C"])
            observableOfAny.onCompleted()
            return Disposables.create {
                print("Disposable")
            }
        }).subscribe(onNext: { (x) in
            print(x)
        })
    }
    
    // subject
    func subject_demo1() {
        var publishSubject = PublishSubject<Any>()
        publishSubject.onNext("A")
        var publishSubscription = publishSubject.subscribe {
            print($0)
        }
        publishSubject.onNext("B")
        publishSubject.onCompleted()
    }
    
    func subject_demo2() {
        var behaviorSubject = BehaviorSubject.init(value: "A")
        var behaviorSubjectSubscription = behaviorSubject.subscribe {
            print($0)
        }
        behaviorSubject.onNext("B")
        behaviorSubject.onCompleted()
    }
    
    func subject_demo3() {
        var replaySubject = ReplaySubject<Any>.create(bufferSize: 2)
        var replaySubjectSubscription1 = replaySubject.subscribe {
            print("Subscription1-> \($0)")
        }
        replaySubject.onNext("A")
        replaySubject.onNext("B")
        replaySubject.onNext("C")
        var replaySubjectSubscription2 = replaySubject.subscribe {
            print("Subscription2-> \($0)")
        }
        replaySubject.onCompleted()
    }
}
