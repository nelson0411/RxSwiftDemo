//
//  Contributor.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/12.
//

import Foundation
import UIKit

struct Contributor {
    
    let name: String
    let gitHubId: String
    var image: UIImage?
    
    init(name: String, gitHubId: String) {
        self.name = name
        self.gitHubId = gitHubId
        image = UIImage(named: "")
    }
}

extension Contributor: CustomStringConvertible {
    var description: String {
        return "\(name): github.com/\(gitHubId)"
    }
}
