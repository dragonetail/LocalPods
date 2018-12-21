//
//  ExampleViewControllerType.swift
//  AutolayoutAndPurelayout
//
//  Created by 孙玉新 on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

class BaseViewControllerWithPurelayout: UIViewController {
    #if DEBUG
        override func loadView() {
            print("\(self.title ?? "") loadView~~~")
            super.loadView()
            _ = self.view.configureForAutoresizingMask(accessibilityIdentifier)

            print("\(self.title ?? "") setupAndComposeView.")
            setupAndComposeView()

            // bootstrap Auto Layout
            view.setNeedsUpdateConstraints()
            print("\(self.title ?? "") loadView...")
        }


        override func viewDidLoad() {
            print("\(self.title ?? "") viewDidLoad~~~")
            super.viewDidLoad()
            print("\(self.title ?? "") viewDidLoad...")
        }

        override func viewWillAppear(_ animated: Bool) {
            print("\(self.title ?? "") viewWillAppear(\(animated))~~~")
            super.viewWillAppear(animated)

            print("\(self.title ?? "") viewWillAppear(\(animated))...")
        }

        override func viewDidAppear(_ animated: Bool) {
            print("\(self.title ?? "") viewDidAppear(\(animated))~~~")
            super.viewDidAppear(animated)

            self.view.printConstraints()
            print("...")
            self.view.superview?.printConstraints()

            print("\(self.title ?? "") viewDidAppear(\(animated))...")
        }

        override func viewWillDisappear(_ animated: Bool) {
            print("\(self.title ?? "") viewWillDisappear(\(animated))~~~")
            super.viewWillDisappear(animated)

            print("\(self.title ?? "") viewWillDisappear(\(animated))...")
        }

        override func viewDidDisappear(_ animated: Bool) {
            print("\(self.title ?? "") viewDidDisappear(\(animated))~~~")
            super.viewDidDisappear(animated)

            print("\(self.title ?? "") viewDidDisappear(\(animated))...")
        }

        override func viewWillLayoutSubviews() {
            print("\(self.title ?? "") viewWillLayoutSubviews~~~")
            super.viewWillLayoutSubviews()

            print("\(self.title ?? "") viewWillLayoutSubviews...")
        }

        override func viewDidLayoutSubviews() {
            print("\(self.title ?? "") viewDidLayoutSubviews~~~")
            super.viewDidLayoutSubviews()

            print("\(self.title ?? "") viewDidLayoutSubviews...")
        }

        override func updateViewConstraints() {
            print("\(self.title ?? "") updateViewConstraints~~~")
            if (!didSetupConstraints) {
                didSetupConstraints = true
                print("\(self.title ?? "") setupConstraints.")
                setupConstraints()
            }
            print("\(self.title ?? "") modifyConstraints.")
            modifyConstraints()

            super.updateViewConstraints()
            print("\(self.title ?? "") updateViewConstraints...")
        }

    #else
        override func loadView() {
            super.loadView()
            _ = self.view.configureForAutoresizingMask(accessibilityIdentifier)

            setupAndComposeView()

            // bootstrap Auto Layout
            view.setNeedsUpdateConstraints()
        }

        override func updateViewConstraints() {
            if (!didSetupConstraints) {
                didSetupConstraints = true
                setupConstraints()
            }
            modifyConstraints()

            super.updateViewConstraints()
        }
    #endif
    var accessibilityIdentifier: String = "VC"

    func setupAndComposeView() {
    }

    fileprivate var didSetupConstraints = false
    func setupConstraints() {
    }
    func modifyConstraints() {
    }
}

extension UIView {
    func configureForAutoLayout(_ accessibilityIdentifier: String? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false;
        if let accessibilityIdentifier = accessibilityIdentifier {
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        return self
    }

    func configureForAutoresizingMask(_ accessibilityIdentifier: String? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = true;
        if let accessibilityIdentifier = accessibilityIdentifier {
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        return self
    }

    func printConstraints() {
        #if DEBUG
            self.constraints.forEach { (constraint) in
                print(String(describing: constraint))
            }
        #endif
    }
}
