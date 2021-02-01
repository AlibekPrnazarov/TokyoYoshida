//
//  MenuDataSource.swift
//  ExampleOfiOSLiDAR
//
//  Created by TokyoYoshida on 2021/01/31.
//

import UIKit

struct MenuItem {
    let title: String
    let description: String
    let prefix: String
    
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: prefix, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.title = title

        return vc
    }
}

class MenuViewModel {
    private let dataSource = [
        MenuItem (
            title: "Depth Map",
            description: "Display the depth map on the screen.",
            prefix: "DepthMap"
        ),
        MenuItem (
            title: "Confidence Map",
            description: "Display the confi confidence on the screen.",
            prefix: "ConfidenceMap"
        ),
        MenuItem (
            title: "Collision",
            description: "Collision detection of objects using LiDAR.",
            prefix: "Collision"
        )
    ]
    
    var count: Int {
        dataSource.count
    }
    
    func item(row: Int) -> MenuItem {
        dataSource[row]
    }
    
    func viewController(row: Int) -> UIViewController {
        dataSource[row].viewController()
    }
}
