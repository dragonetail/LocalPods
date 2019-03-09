//
//  UINavigationController+Extension.swift
//  TabMenuExample
//
//  Created by kukushi on 25/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit

open class TabMenuNavigationController: UINavigationController {
    open var rootViewController: UIViewController?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    public static func wrapper(_ viewController: UIViewController) -> UINavigationController {
        let navigationController = TabMenuNavigationController(rootViewController: viewController)
        navigationController.rootViewController = viewController
        return navigationController
    }
}
