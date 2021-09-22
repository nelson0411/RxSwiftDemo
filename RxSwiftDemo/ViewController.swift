//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/10.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    
    var dispossBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        
        //----
//        let numberSequence = Observable.just(5)
//        let numberSubscription = numberSequence.subscribe(onNext: {x in
//            print(x)
//        })
        
//        let helloSequence = Observable.from(["a","b","c"])
//        let helloSubscription = helloSequence.subscribe { (next) in
//            switch next {
//            case .next(let value):
//                print(value)
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("ok")
//            }
//        }
        
        //----
//        _ = Observable<String>.create({ (observeOfString) -> Disposable in
//            print("创建观察者")
//
//            observeOfString.on(.next("1111"))
//            observeOfString.on(.completed)
//            return Disposables.create {
//                print("销毁释放了")
//            }
//        }).subscribe({ event in
//            print(event)
//        })
        
//        _ = Observable<String>.create({ (observeOfString) -> Disposable in
//            print("创建观察者")
//
//            observeOfString.on(.next("1111"))
//            observeOfString.on(.completed)
//            return Disposables.create {
//                print("销毁释放了")
//            }
//        }).subscribe(onNext: { (x) in
//            print(x)
//        })
        
        
        //----
//        _ = Observable<Any>.create({ (observe) -> Disposable in
//            print("创建观察者")
//
//            observe.on(.next(5))
//            observe.on(.next("aa"))
//            observe.on(.next(["1","2"]))
//            observe.on(.next(["a":"1","b":"2"]))
//            observe.on(.completed)
//            return Disposables.create()
//
//        }).subscribe({ (event) in
//            switch event {
//            case .next(let x):
//                print(x)
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("ok")
//            }
//        })
        
        //----
//        var publishSubject = PublishSubject<Any>()
//        publishSubject.on(.next("hello1"))
//
//        var publishSubcription = publishSubject.subscribe({
//            print($0)
//        })
//        publishSubject.on(.next("hello2"))
//
//        //----
//        let behaviorSubject = BehaviorSubject(value: "A")
//        let subscribeOne = behaviorSubject.subscribe({
//            print("订阅者1号 \($0)")
//        })
//        behaviorSubject.onNext("B")
//        behaviorSubject.onNext("C")
//        behaviorSubject.onNext("D")
//        behaviorSubject.on(.next("E"))
//
//        let subscribeTwo = behaviorSubject.subscribe({
//            print("订阅者2号 \($0)")
//        })
//
//        behaviorSubject.on(.next("F"))
//        behaviorSubject.onCompleted()

        
        //----
//        var replaySubject = ReplaySubject<Double>.create(bufferSize: 3)
//        var subscribe1 = replaySubject.subscribe({
//            print("第1个\($0)")
//        })
//        replaySubject.onNext(1.0)
//        replaySubject.onNext(2.0)
//        replaySubject.onNext(3.0)
//        replaySubject.onNext(4.0)
//        var subscribe2 = replaySubject.subscribe({
//            print("第2个\($0)")
//        })
        
        self.nameField.frame = CGRect.init(x: 50, y: 200, width: 300, height: 50)
        view.addSubview(self.nameField)
        
        self.passWordField.frame = CGRect.init(x: 50, y: 270, width: 300, height: 50)
        view.addSubview(self.passWordField)
        
        self.loginBtn.frame = CGRect.init(x: 50, y: 340, width: 300, height: 50)
        view.addSubview(self.loginBtn)
        
        self.pushBtn1.frame = CGRect.init(x: 30, y: 440, width: 100, height: 50)
        view.addSubview(self.pushBtn1)

        self.pushBtn2.frame = CGRect.init(x: 30+100+15, y: 440, width: 100, height: 50)
        view.addSubview(self.pushBtn2)
        
        self.pushBtn3.frame = CGRect.init(x: (30+100+15)+100+15, y: 440, width: 100, height: 50)
        view.addSubview(self.pushBtn3)
        
        self.pushBtn4.frame = CGRect.init(x: 30, y: 440+50+10, width: 100, height: 50)
        view.addSubview(self.pushBtn4)
        
        self.pushBtn5.frame = CGRect.init(x: 30+100+15, y: 440+50+10, width: 100, height: 50)
        view.addSubview(self.pushBtn5)
        
        self.pushBtn6.frame = CGRect.init(x: (30+100+15)+100+15, y: 440+50+10, width: 100, height: 50)
        view.addSubview(self.pushBtn6)
        
        bindTextField()
        bindButton()
    }
    
    //--
    func bindTextField() {
        self.nameField.rx.text
            .map({
                if $0 == "" {
                    return "ha"
                } else {
                    return "hello \($0!)"
                }
            })
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: self.passWordField.rx.text)
            .disposed(by: dispossBag)
    }
    
    var nameArray: [String] = []
    
    //--
    func bindButton() {
        self.loginBtn.rx.tap.subscribe({_ in
            if self.nameField.text != "" {
                self.nameArray.append(self.nameField.text!)
            }
            print("rx: \(self.nameArray)")
            self.passWordField.rx.text.onNext(self.nameArray.joined(separator: ","))
            self.nameField.rx.text.onNext("")
        }).disposed(by: dispossBag)
    }
    
    @objc func clickBtn() {
        print("click: \(self.nameArray)")
    }
    
    @objc func clickPushBtn1() {
        let subVC = SubViewController.init()
        self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    @objc func clickPushBtn2() {
        let subVC = ThirdViewController.init()
        self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    @objc func clickPushBtn3() {
        let subVC = FourthViewController.init()
        self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    @objc func clickPushBtn4() {
        let subVC = FiveViewController.init()
        self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    @objc func clickPushBtn5() {
        let subVC = SixViewController.init()
        self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    @objc func clickPushBtn6() {
        let subVC = SevenViewController.init()
        self.navigationController?.pushViewController(subVC, animated: true)
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
        button.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
        button.setTitle("点击", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var pushBtn1: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickPushBtn1), for: UIControl.Event.touchUpInside)
        button.setTitle("push1", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var pushBtn2: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickPushBtn2), for: UIControl.Event.touchUpInside)
        button.setTitle("push2", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var pushBtn3: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickPushBtn3), for: UIControl.Event.touchUpInside)
        button.setTitle("push3", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var pushBtn4: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickPushBtn4), for: UIControl.Event.touchUpInside)
        button.setTitle("push4", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var pushBtn5: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickPushBtn5), for: UIControl.Event.touchUpInside)
        button.setTitle("push5", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var pushBtn6: UIButton = {
        let button: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(clickPushBtn6), for: UIControl.Event.touchUpInside)
        button.setTitle("push6", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
}

extension ViewController {
    
}

