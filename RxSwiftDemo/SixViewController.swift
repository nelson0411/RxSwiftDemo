//
//  SixViewController.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/12.
//

import UIKit
import RxSwift
import RxCocoa


class SixViewController: UIViewController {
    
    let data: [Contributor] = [
        Contributor(name: "a", gitHubId: "1"),
        Contributor(name: "b", gitHubId: "2"),
        Contributor(name: "c", gitHubId: "3"),
        Contributor(name: "d", gitHubId: "4"),
        Contributor(name: "e", gitHubId: "5"),
        Contributor(name: "f", gitHubId: "6")
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
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


extension SixViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        else {
            return UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        }
        
        let contributor = data[indexPath.row]
        cell.textLabel?.text = contributor.name
        cell.detailTextLabel?.text = contributor.gitHubId
        return cell
    }
}


extension SixViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you select", data[indexPath.row])
    }
}
