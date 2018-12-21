//
//  ExampleViewControllerType.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

open class BaseViewControllerWithAutolayout: UIViewController {
    open var accessibilityIdentifier: String {
        return "BaseViewController"
    }
    open override func loadView() {
        #if DEBUG
            print("--- \(self.accessibilityIdentifier) loadView")
        #endif
        super.loadView()
        _ = self.view.autoresizingMask(accessibilityIdentifier)

        #if DEBUG
            print("... \(self.accessibilityIdentifier) loadView: setupAndComposeView")
        #endif
        setupAndComposeView()

        // bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
        #if DEBUG
            print("^^^ \(self.accessibilityIdentifier) loadView")
        #endif
    }

    #if DEBUG
        open override func viewDidLoad() {
            print("--- \(self.accessibilityIdentifier) viewDidLoad")
            super.viewDidLoad()
            print("^^^ \(self.accessibilityIdentifier) viewDidLoad")
        }

        open override func viewWillAppear(_ animated: Bool) {
            print("--- \(self.accessibilityIdentifier) viewWillAppear(\(animated))")
            super.viewWillAppear(animated)
            print("^^^ \(self.accessibilityIdentifier) viewWillAppear(\(animated))")
        }

        open override func viewDidAppear(_ animated: Bool) {
            print("--- \(self.accessibilityIdentifier) viewDidAppear(\(animated))")
            super.viewDidAppear(animated)
            print("^^^ \(self.accessibilityIdentifier) viewDidAppear(\(animated))")
        }

        open override func viewWillDisappear(_ animated: Bool) {
            print("--- \(self.accessibilityIdentifier) viewWillDisappear(\(animated))")
            super.viewWillDisappear(animated)
            print("^^^ \(self.accessibilityIdentifier) viewWillDisappear(\(animated))")
        }

        open override func viewDidDisappear(_ animated: Bool) {
            print("--- \(self.accessibilityIdentifier) viewDidDisappear(\(animated))")
            super.viewDidDisappear(animated)
            print("^^^ \(self.accessibilityIdentifier) viewDidDisappear(\(animated))")
        }

        open override func viewWillLayoutSubviews() {
            print("--- \(self.accessibilityIdentifier) viewWillLayoutSubviews")
            super.viewWillLayoutSubviews()
            print("^^^ \(self.accessibilityIdentifier) viewWillLayoutSubviews")
        }


        open var autoPrintAll: Bool {
            return false
        }
        open var autoPrintViewLayoutTrace: Bool {
            return false
        }
        open var autoPrintSelfViewConstraints: Bool {
            return false
        }
        open var autoPrintSuperViewConstraints: Bool {
            return false
        }
        open override func viewDidLayoutSubviews() {
            print("--- \(self.accessibilityIdentifier) viewDidLayoutSubviews")
            super.viewDidLayoutSubviews()

            if autoPrintAll || autoPrintViewLayoutTrace {
                print("")
                print("...... \(self.accessibilityIdentifier) autoPrintViewLayoutTrace ......")
                print(self.view.value(forKey: "_autolayoutTrace") ?? "")
                print("")
            }
            if autoPrintAll || autoPrintSelfViewConstraints {
                print("")
                print("...... \(self.accessibilityIdentifier) autoPrintSelfViewConstraints ......")
                self.view.autoPrintConstraints()
                print("")
            }
            if autoPrintAll || autoPrintSuperViewConstraints {
                print("")
                print("...... \(self.accessibilityIdentifier) autoPrintSuperViewConstraints ......")
                self.view.superview?.autoPrintConstraints()
                print("")
            }

            print("\(self.accessibilityIdentifier) viewDidLayoutSubviews")
        }
    #endif

    fileprivate var didSetupConstraints = false
    open override func updateViewConstraints() {
        #if DEBUG
            print("--- \(self.accessibilityIdentifier) updateViewConstraints")
        #endif
        if (!didSetupConstraints) {
            didSetupConstraints = true
            #if DEBUG
                print("... \(self.accessibilityIdentifier) updateViewConstraints: setupConstraints.")
            #endif
            setupConstraints()
        }
        #if DEBUG
            print("... \(self.accessibilityIdentifier) updateViewConstraints: modifyConstraints.")
        #endif
        modifyConstraints()

        super.updateViewConstraints()
        #if DEBUG
            print("^^^ \(self.accessibilityIdentifier) updateViewConstraints")
        #endif
    }

    open func setupAndComposeView() {
    }
    open func setupConstraints() {
    }
    open func modifyConstraints() {
    }
}


