//
//  ViewDemoController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/13.
//

import UIKit

class ViewDemoController: UIViewController {
    
    let data: [String] = [
        "vc2",
        "vc3",
        "vc4",
        "vc5",
        "vc6",
        "vc7",
        "vc8"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
        view.addSubview(tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

}


extension ViewDemoController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        else {
            return UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        }
        
        let content = data[indexPath.row]
        cell.textLabel?.text = content
        return cell
    }
}


extension ViewDemoController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("you select", data[indexPath.row])
        
        var vc: UIViewController
        
        switch indexPath.row {
        case 0:
            vc = ViewController2.init()
        case 1:
            vc = ViewController3.init()
        case 2:
            vc = ViewController4.init()
        case 3:
            vc = ViewController5.init()
        case 4:
            vc = ViewController6.init()
        case 5:
            vc = ViewController7.init()
        case 6:
            vc = ViewController8.init()
        default:
            vc = UIViewController.init()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
