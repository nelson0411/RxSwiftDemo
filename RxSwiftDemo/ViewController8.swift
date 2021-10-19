//
//  ViewController8.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/18.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController8: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        demo5()
    }
    
    func demo1() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        
        URLSession.shared.rx.response(request: request)
            .subscribe { (response, data) in
                print("respons = \(response), data = \(data)")
                let responseDataStr = String(data: data, encoding: String.Encoding.utf8)
                print(responseDataStr ?? "")
            }
            .disposed(by: disposeBag)
    }
    
    func demo2() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        
        URLSession.shared.rx.data(request: request)
            .subscribe(onNext: { (data) in
                let responseDataStr = String(data: data, encoding: String.Encoding.utf8)
                print(responseDataStr ?? "")
            })
            .disposed(by: disposeBag)
    }
    
    func demo3() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        
        URLSession.shared.rx.data(request: request)
            .subscribe(onNext: { (data) in
                let jsonStr = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                print(jsonStr ?? "")
            })
            .disposed(by: disposeBag)
    }
    
    func demo4() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        
        URLSession.shared.rx.json(request: request)
            .subscribe(onNext: { (data) in
                print(data)
            })
            .disposed(by: disposeBag)
    }
    
    func demo5() {
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        
        let tableView = UITableView.init(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let data = URLSession.shared.rx.json(request: request)
            .map({ result -> [[String: Any]] in
                if let dict = result as? [String: Any], let channels = dict["channels"] as? [[String: Any]] {
                    return channels
                } else {
                    return []
                }
            })
        
        data.bind(to: tableView.rx.items(cellIdentifier: "Cell"), curriedArgument: { (index, dict, cell) in
            cell.textLabel?.text = dict["name"] as? String
        })
        .disposed(by: disposeBag)
    }

}
