//
//  ViewController5.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/12.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController5: MyViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        buttonDemo2()
    }
    
    //label->text
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
    
    //label->attributedText
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
    
    //textField->asObservable
    func textFieldDemo1() {
        let textField = UITextField.init()
        textField.frame = CGRect.init(x: 50, y: 220, width: 200, height: 50)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(textField)
        
        //--可选类型
//        textField.rx.text.asObservable()
//            .subscribe { (text) in
//                print(text)
//            }
//            .disposed(by: disposeBag)
        
        //--
//        textField.rx.text.orEmpty.asObservable()
//            .subscribe { text in
//                print(text)
//            }
//            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.changed
            .subscribe { text in
                print(text)
            }
            .disposed(by: disposeBag)
    }

    //textField->drive
    func textFieldDemo2() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:140, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
         
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:210, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
         
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
         
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        let input = inputField.rx.text.orEmpty.asDriver().throttle(RxTimeInterval.seconds(1))
        
        input
            .drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        input
            .map {
                "当前字数：\($0.count)"
            }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        input
            .map({
                $0.count > 5
            })
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    //textField->combine
    func textFieldDemo3() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:140, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
         
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:210, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
         
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
        
        Observable.combineLatest(inputField.rx.text.orEmpty, outputField.rx.text.orEmpty) { text1, text2 -> String in
            return "你输入的号码是：\(text1)-\(text2)"
        }
        .map({$0})
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
    }
    
    //textField->controlEvent
    func textFieldDemo4() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:140, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        inputField.rx.controlEvent([UIControl.Event.editingDidBegin, .editingChanged, .editingDidEnd])
            .asObservable()
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
    }
    
    //textField->controlEvent
    func textFieldDemo5() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:140, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
         
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:210, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        inputField.rx.controlEvent([UIControl.Event.editingDidEndOnExit])
            .asObservable()
            .subscribe { _ in
                outputField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        outputField.rx.controlEvent([UIControl.Event.editingDidEndOnExit])
            .asObservable()
            .subscribe { _ in
                outputField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
    }
    
    //UITextView
    func textTextView1() {
        let textView = UITextView(frame: CGRect(x:10, y:140, width:200, height:200))
        textView.layer.borderWidth = CGFloat(1.0)
        textView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(textView)
        
        /*
        /// Reactive wrapper for `delegate` message.
        public var didBeginEditing: RxCocoa.ControlEvent<()> { get }

        /// Reactive wrapper for `delegate` message.
        public var didEndEditing: RxCocoa.ControlEvent<()> { get }

        /// Reactive wrapper for `delegate` message.
        public var didChange: RxCocoa.ControlEvent<()> { get }

        /// Reactive wrapper for `delegate` message.
        public var didChangeSelection: RxCocoa.ControlEvent<()> { get }
        */
        
        textView.rx.didBeginEditing
            .subscribe({ _ in
                print("didBeginEditing")
            })
            .disposed(by: disposeBag)
        
        textView.rx.didEndEditing
            .subscribe({ _ in
                print("didEndEditing")
            })
            .disposed(by: disposeBag)
        
        textView.rx.didChange
            .subscribe({ _ in
                print("didChange")
            })
            .disposed(by: disposeBag)
        
        textView.rx.didChangeSelection
            .subscribe({ _ in
                print("didChangeSelection")
            })
            .disposed(by: disposeBag)
        
        let tgr = UITapGestureRecognizer()
        view.addGestureRecognizer(tgr)
        
        tgr.rx.event
            .subscribe { [weak self ] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    //UIButton
    func buttonDemo1() {
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:10, y:140, width:100, height:50)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        button.rx.tap
            .subscribe({
                print($0)
            })
            .disposed(by: disposeBag)
        
        let ob = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        ob.map({"\($0)"})
            .bind(to: button.rx.title(for: .normal))
            .disposed(by: disposeBag)
    }
    
    //UIButton
    func buttonDemo2() {
        //创建按钮
        let button1:UIButton = UIButton(type:.system)
        button1.frame = CGRect(x:10, y:140, width:100, height:50)
        button1.setTitle("提交1", for:.normal)
        self.view.addSubview(button1)
        
        //创建按钮
        let button2:UIButton = UIButton(type:.system)
        button2.frame = CGRect(x:10, y:200, width:100, height:50)
        button2.setTitle("提交2", for:.normal)
        self.view.addSubview(button2)
        
        //创建按钮
        let button3:UIButton = UIButton(type:.system)
        button3.frame = CGRect(x:10, y:260, width:100, height:50)
        button3.setTitle("提交3", for:.normal)
        self.view.addSubview(button3)
        
        //默认选中第一个按钮
        button1.isSelected = true
        
        //强制解包，避免后面还需要处理可选类型
        let buttons = [button1, button2, button3].map({$0!})
        
        //创建一个可观察序列，它可以发送最后一次点击的按钮（也就是我们需要选中的按钮）
        let selectedBtn = Observable.from(buttons.map({ button in
            button.rx.tap.map({button})
        })).merge()
        
        for btn in buttons {
            selectedBtn
                .map({$0==btn})
                .bind(to: btn.rx.isSelected)
                .disposed(by: disposeBag)
        }
    }
}
