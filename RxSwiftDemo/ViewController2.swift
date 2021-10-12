//
//  ViewController2.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/8.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController2: UIViewController {
    
    let musicListViewModel = MusicListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        /**
            Subscribes to observable sequence using custom binder function and final parameter passed to binder function
            after `self` is passed.
        
                public func bind<R1, R2>(to binder: Self -> R1 -> R2, curriedArgument: R1) -> R2 {
                    return binder(self)(curriedArgument)
                }
        
            - parameter to: Function used to bind elements from `self`.
            - parameter curriedArgument: Final argument passed to `binder` to finish binding process.
            - returns: Object representing subscription.
            */
//        public func bind<R1, R2>(to binder: (Self) -> (R1) -> R2, curriedArgument: R1) -> R2

        
//        musicListViewModel.data
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, myMusic, myCell in
//                myCell.textLabel?.text = myMusic.name
//                myCell.detailTextLabel?.text = myMusic.singer
//            }.disposed(by: disposeBag)
        
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self), curriedArgument: { index, myMusic, myCell in
                myCell.textLabel?.text = myMusic.name
                myCell.detailTextLabel?.text = myMusic.singer
            }).disposed(by: disposeBag)
        
//        public func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
//            (cellIdentifier: String, cellType: Cell.Type = Cell.self)
//            -> (_ source: Source)
//            -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
//            -> Disposable
//            where Source.Element == Sequence {
//            return { source in
//                return { configureCell in
//                    let dataSource = RxTableViewReactiveArrayDataSourceSequenceWrapper<Sequence> { tv, i, item in
//                        let indexPath = IndexPath(item: i, section: 0)
//                        let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
//                        configureCell(i, item, cell)
//                        return cell
//                    }
//                    return self.items(dataSource: dataSource)(source)
//                }
//            }
//        }
        
        tableView.rx.modelSelected(Music.self)
            .subscribe(onNext: { music in
                print(music.description)
            }).disposed(by: disposeBag)
    }

    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
}
