//
//  SevenViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/12.
//

import UIKit
import RxSwift
import RxCocoa

class SevenViewController: UIViewController {

    let data = Observable.of([
        Contributor(name: "a", gitHubId: "1"),
        Contributor(name: "b", gitHubId: "2"),
        Contributor(name: "c", gitHubId: "3"),
        Contributor(name: "d", gitHubId: "4"),
        Contributor(name: "e", gitHubId: "5"),
        Contributor(name: "f", gitHubId: "6")
    ])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        data.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "Cell")){_, contributor, cell in
                cell.textLabel?.text = contributor.name
                cell.detailTextLabel?.text = contributor.gitHubId
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Contributor.self)
            .subscribe(onNext: {
                print("select \($0)")
            })
            .disposed(by: disposeBag)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
}
