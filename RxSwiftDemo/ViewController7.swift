//
//  ViewController7.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/18.
//

import UIKit
import RxCocoa
import RxSwift


//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}
 
extension MySection {
    typealias Item = String
     
    var identity: String {
        return header
    }
     
//    init(original: MySection, items: [Item]) {
//        self = original
//        self.items = items
//    }
}

class ViewController7: UIViewController {

    let disposeBag = DisposeBag()
    
    //初始化数据
    let items = Observable.just([
        MySection.init(header: "One", items: [
            "UILable的用法",
            "UIText的用法",
            "UIButton的用法"
        ]),
        MySection.init(header: "Two", items: [
            "UILable的用法",
            "UIText的用法",
            "UIButton的用法"
        ])
    ])
    
    //tableview高级用法
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        //创建数据源
        var dataSource = RxTableViewDataSourcePrefetchingProxy.init(tableView: tableView)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style:.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

}
