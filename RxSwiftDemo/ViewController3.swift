//
//  ViewController3.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/9.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController3: UIViewController {

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
        
        demo8()
    }
    
    // bind {} 方式
    func demo1() {
        let anyObserver = AnyObserver<Int>.init { event in
            print(event.element)
        }
        
        //--
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .bind{[weak self] index in
                print(index)
            }
            .disposed(by: disposeBag)
        
        observable
            .bind(to: anyObserver)
            .disposed(by: disposeBag)
    }

    
    //AnyObserver -》 bind to 方式
    func demo2() {
        
        let observer: AnyObserver<Int> = AnyObserver { evnet in
            switch evnet {
            case .next(let index):
                print(index)
            case .completed:
                print("completed")
            default:
                print("1")
            }
        }
        
        let observable = Observable<Int>.timer(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    //Observable->create 方式
    func deme3() {
        let observable = Observable<String>.create{ observer in
            observer.onNext("A")
            observer.onCompleted()
            return Disposables.create()
        }
        
        _ = observable.subscribe {
            print($0)
        }
    }
    
    //binder
    func demo4() {
        
        let binder: Binder<String> = Binder(label){ target, value in
            target.text = value
        }
        
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map {"转换->\($0)"}
            .bind(to: binder)
            .disposed(by: disposeBag)
    }
    
    //extension label
    func demo5() {
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map({"\($0)"})
            .bind(to: label.rx.myText)
            .disposed(by: disposeBag)
    }
    
    //subject->PublishSubject
    func demo6() {
        let publishSubject = PublishSubject<String>()
        publishSubject.onNext("0000")
        //第一次订阅
        publishSubject.subscribe{ event in
            print("第一次订阅-> \(String(describing: event.element))")
        }.disposed(by: disposeBag)
        
        publishSubject.onNext("1111")
        
        //第二次订阅
        publishSubject.subscribe { event in
            print("第二次订阅-> \(String(describing: event.element))")
        }.disposed(by: disposeBag)

        publishSubject.onNext("2222")
        
        //让publishSubject结束
        publishSubject.onCompleted()
        
        //第三次订阅
        publishSubject.subscribe { event in
            print("第三次订阅-> \(String(describing: event.element))")
        }.disposed(by: disposeBag)
    }
    
    //subject->BehaviorSubject
    func demo7() {
        let behaviorSubject = BehaviorSubject<String>.init(value: "1111")
        //第一次订阅
        behaviorSubject.subscribe { (value) in
            print("第一次订阅-> \(value)")
        } onError: { (error) in
            print("第一次订阅error")
        } onCompleted: {
            print("第一次订阅complet")
        } onDisposed: {
            print("第一次订阅onDisposed")
        }.disposed(by: disposeBag)

        behaviorSubject.onNext("2222")
        
        //第二次订阅
        behaviorSubject.subscribe { (value) in
            print("第二次订阅-> \(value)")
        } onError: { (error) in
            print("第二次订阅error")
        } onCompleted: {
            print("第二次订阅conplete")
        } onDisposed: {
            print("第二次订阅onDisposed")
        }.disposed(by: disposeBag)

        behaviorSubject.onCompleted()
        
        //第三次订阅
        behaviorSubject.subscribe { (value) in
            print("第三次订阅-> \(value)")
        } onError: { (error) in
            print("第三次订阅error")
        } onCompleted: {
            print("第三次订阅conplete")
        } onDisposed: {
            print("第三次订阅onDisposed")
        }.disposed(by: disposeBag)
    }

    //subject->BehaviorRelay
    func demo8() {
        let behaviorRelay = BehaviorRelay<String>.init(value: "0000")
        
        //第一次订阅
        behaviorRelay.subscribe { (value) in
            print("第一次订阅-> \(value)")
        } onError: { (error) in
            print("第一次订阅error")
        } onCompleted: {
            print("第一次订阅complet")
        } onDisposed: {
            print("第一次订阅onDisposed")
        }.disposed(by: disposeBag)

        //--
        behaviorRelay.accept("1111")
        
        //第二次订阅
        behaviorRelay.subscribe { (value) in
            print("第二次订阅-> \(value)")
        } onError: { (error) in
            print("第二次订阅error")
        } onCompleted: {
            print("第二次订阅conplete")
        } onDisposed: {
            print("第二次订阅onDisposed")
        }.disposed(by: disposeBag)
    }

}

extension Reactive where Base: UILabel {
    public var myText: Binder<String> {
        return Binder(self.base){ target, value in
            target.text = value
        }
    }
}
