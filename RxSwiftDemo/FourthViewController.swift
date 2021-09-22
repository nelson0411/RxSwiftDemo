//
//  FourthViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/11.
//

import UIKit
import RxSwift
import RxCocoa

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        
        demo11()
    }
    
    // RxSwift : 一个叫观察者 (Observer) 可观察对象 (Observable)
    
    //创建一个不会发射任何数据的 observable
    func demo1() {
        example(of: "never") {
            let disposeBag = DisposeBag()
            let neverSequnce = Observable<String>.never()
//            let neverSequnce = Observable.just(5)
            neverSequnce.subscribe {
                print($0)
                //print("never")
            }.disposed(by: disposeBag)
        }
    }
    
    
    //创建一个不会通知内容，只告诉完成了
    func demo2() {
        example(of: "empty") {
            let disposeBag = DisposeBag()
            let emptyObservable = Observable<Int>.empty()
            emptyObservable.subscribe {
                print($0)
            }.disposed(by: disposeBag)
        }
    }
    
    //创建一个只有一个同事的 observable
    func demo3() {
        example(of: "just") {
            let disposeBag = DisposeBag()
            let justObservable = Observable<Int>.just(5)
            justObservable.subscribe {
                print($0)
            }.disposed(by: disposeBag)
        }
    }
    
    //of 把一系列的元素，转换成事件序列的 observable
    func demo4() {
        example(of: "just") {
            let disposeBag = DisposeBag()
            let ofObservable = Observable.of(1,2,3,4,5)
//            ofObservable.subscribe {
//                print($0)
//            }.disposed(by: disposeBag)
            
            ofObservable.subscribe { (event) in
                print(event)
            } onError: { (error) in
                print("error")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }.disposed(by: disposeBag)
        }
    }
    
    //from 把序列，转换成事件序列 observable
    func demo5() {
        example(of: "just") {
            let disposeBag = DisposeBag()
            let ofObservable = Observable.from([1,2,3,4,5])
            ofObservable.subscribe {
                print($0)
//                onNext: { print($0) },
//                onCompleted: { print("onCompleted") },
//                onError: { print("onError") }
            }.disposed(by: disposeBag)
        }
    }
    
    //error
    func demo6() {
        example(of: "error") {
            let disposeBag = DisposeBag()
            enum MyError: Error {
                case test
            }
            let errorObservable = Observable<Any>.error(MyError.test)
            errorObservable.subscribe {
                print($0)
            }.disposed(by: disposeBag)
        }
    }
    
    //-----------------------------------------
    
    //create
    func demo7() {
        example(of: "create") {
            let myJust = {(element: String) -> Observable<String> in
                return Observable.create { (observable) -> Disposable in
                    observable.onNext(element)
                    observable.onCompleted()
                    return Disposables.create()
                }
            }
            myJust("apple")
                .subscribe({
                    print($0)
                })
                .disposed(by: DisposeBag())
        }
    }
    
    //-----------------------------------------

    //subject
    func demo9() {
        
        let disposeBag = DisposeBag()
        
        example(of: "publishSubject") {
            let pubSubject = PublishSubject<Any>()
            pubSubject.onNext("1")
            //pubSubject.subscribe({
            //    print($0)
            //}).disposed(by: disposeBag)
            
            //第一组
            pubSubject.addObservable("No1").disposed(by: disposeBag)
            pubSubject.onNext("A")
            pubSubject.onNext("B")
            //第二组
            pubSubject.addObservable("No2").disposed(by: disposeBag)
            pubSubject.onNext("1")
            pubSubject.onNext("2")
        }
    }
    
    //subject
    func demo10() {
        
        let disposeBag = DisposeBag()
        
        example(of: "replaySubject") {
            let repSubject = ReplaySubject<String>.create(bufferSize: 2)
            repSubject.onNext("1")
            //第一组
            repSubject.addObservable("No1").disposed(by: disposeBag)
            repSubject.onNext("A")
            repSubject.onNext("B")
            //第二组
            repSubject.addObservable("No2").disposed(by: disposeBag)
            repSubject.onNext("1")
            repSubject.onNext("2")
        }
    }
    
    //subject
    func demo11() {
        
        let disposeBag = DisposeBag()
        
        example(of: "replaySubject") {
            let behSubject = BehaviorSubject<String>.init(value: "123")
            behSubject.onNext("1")
            //第一组
            behSubject.addObservable("No1").disposed(by: disposeBag)
            behSubject.onNext("A")
            behSubject.onNext("B")
            //第二组
            behSubject.addObservable("No2").disposed(by: disposeBag)
            behSubject.onNext("1")
            behSubject.onNext("2")
        }
    }
    
//    //subject
//    func demo12() {
//        
//        let disposeBag = DisposeBag()
//        
//        example(of: "replaySubject") {
//
////            let behSubject = variableS<String>.init(value: "123")
//            behSubject.onNext("1")
//            //第一组
//            behSubject.addObservable("No1").disposed(by: disposeBag)
//            behSubject.onNext("A")
//            behSubject.onNext("B")
//            //第二组
//            behSubject.addObservable("No2").disposed(by: disposeBag)
//            behSubject.onNext("1")
//            behSubject.onNext("2")
//        }
//    }
}


extension ObservableType {
    //给每个观察者增加一个id，并打印id和发射的事件
    func addObservable(_ id: String) -> Disposable {
        return subscribe({
            print("Subscription:", id, "Event", $0)
        })
    }
}
