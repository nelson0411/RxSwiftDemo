//
//  ViewController6.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/13.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController6: UIViewController {

    var items = Observable.just([
        "文本输入框的用法",
        "开关按钮的用法",
        "进度条的用法",
        "文本标签的用法",
    ])
    
    let disposeBag = DisposeBag()
    
    //tableview基本用法
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell"), curriedArgument:{ index, element, cell in
                print("index=\(index), item=\(element), cell=\(cell)")
                cell.textLabel?.text = "\(index)：\(element)"
            })
            .disposed(by: disposeBag)
        
        //点击
//        tableView.rx.itemSelected
//            .subscribe { (indexPath) in
//                print(indexPath)
//            }
//            .disposed(by: disposeBag)
//
//        tableView.rx.itemSelected
//            .subscribe(onNext: { indexPath in
//                print(indexPath)
//            })
//            .disposed(by: disposeBag)
//
//        tableView.rx.modelSelected(String.self)
//            .subscribe({ element in
//                print(element)
//            })
//            .disposed(by: disposeBag)
//
//        tableView.rx.modelSelected(String.self)
//            .subscribe(onNext: { element in
//                print(element)
//            })
//            .disposed(by: disposeBag)
        
        //删除
//        tableView.rx.itemDeleted
//            .subscribe(onNext: { indexPath in
//                print(indexPath)
//            })
//            .disposed(by: disposeBag)
        
        tableView.rx.modelDeleted(String.self)
            .subscribe(onNext: { [weak self] element in
                print(element)
            })
            .disposed(by: disposeBag)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    

}
