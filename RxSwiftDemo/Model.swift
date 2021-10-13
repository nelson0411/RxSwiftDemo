//
//  File.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/10/8.
//

import Foundation
import RxSwift
import RxCocoa


struct Music {
    let name: String
    let singer: String
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}


extension Music: CustomStringConvertible {
    var description: String {
        return "name : \(name), singger: \(singer)"
    }
}

struct MusicListViewModel {
//    let data = [
//        Music(name: "无条件", singer: "陈奕迅"),
//        Music(name: "你曾是少年", singer: "S.H.E"),
//        Music(name: "从前的我", singer: "陈洁仪"),
//        Music(name: "在木星", singer: "朴树"),
//    ]
    
    let data: Observable = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树")
    ])
}
