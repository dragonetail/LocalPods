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

    #if DEBUG
        var debugOutputEnable = true
        fileprivate func log(_ msg: String) {
            if debugOutputEnable {
                print(msg)
            }
        }
    #endif

    open override func loadView() {
        #if DEBUG
            log("--- \(self.accessibilityIdentifier) loadView")
        #endif
        super.loadView()
        _ = self.view.autoResizingMask(accessibilityIdentifier)

        #if DEBUG
            log("... \(self.accessibilityIdentifier) loadView: setupAndComposeView")
        #endif
        setupAndComposeView()

        // bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
        #if DEBUG
            log("^^^ \(self.accessibilityIdentifier) loadView")
        #endif
    }

    #if DEBUG
        open override func viewDidLoad() {
            log("--- \(self.accessibilityIdentifier) viewDidLoad")
            super.viewDidLoad()
            log("^^^ \(self.accessibilityIdentifier) viewDidLoad, frame: \(self.view.frame), bounds: \(self.view.bounds)")
        }

        open override func viewWillAppear(_ animated: Bool) {
            log("--- \(self.accessibilityIdentifier) viewWillAppear(\(animated))")
            super.viewWillAppear(animated)
            log("^^^ \(self.accessibilityIdentifier) viewWillAppear(\(animated))")
        }

        open override func viewDidAppear(_ animated: Bool) {
            log("--- \(self.accessibilityIdentifier) viewDidAppear(\(animated))")
            super.viewDidAppear(animated)
            log("^^^ \(self.accessibilityIdentifier) viewDidAppear(\(animated))")
        }

        open override func viewWillDisappear(_ animated: Bool) {
            log("--- \(self.accessibilityIdentifier) viewWillDisappear(\(animated))")
            super.viewWillDisappear(animated)
            log("^^^ \(self.accessibilityIdentifier) viewWillDisappear(\(animated))")
        }

        open override func viewDidDisappear(_ animated: Bool) {
            log("--- \(self.accessibilityIdentifier) viewDidDisappear(\(animated))")
            super.viewDidDisappear(animated)
            log("^^^ \(self.accessibilityIdentifier) viewDidDisappear(\(animated))")
        }

        open override func viewWillLayoutSubviews() {
            log("--- \(self.accessibilityIdentifier) viewWillLayoutSubviews")
            super.viewWillLayoutSubviews()
            log("^^^ \(self.accessibilityIdentifier) viewWillLayoutSubviews")
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
            log("--- \(self.accessibilityIdentifier) viewDidLayoutSubviews")
            super.viewDidLayoutSubviews()

            if autoPrintAll || autoPrintViewLayoutTrace {
                log("")
                log("...... \(self.accessibilityIdentifier) autoPrintViewLayoutTrace ......")
                log(String(describing: self.view.value(forKey: "_autolayoutTrace")))
                log("")
            }
            if autoPrintAll || autoPrintSelfViewConstraints {
                log("")
                log("...... \(self.accessibilityIdentifier) autoPrintSelfViewConstraints ......")
                self.view.autoPrintConstraints()
                log("")
            }
            if autoPrintAll || autoPrintSuperViewConstraints {
                log("")
                log("...... \(self.accessibilityIdentifier) autoPrintSuperViewConstraints ......")
                self.view.superview?.autoPrintConstraints()
                log("")
            }
            log("^^^ \(self.accessibilityIdentifier) viewDidLayoutSubviews")
        }
    #endif

    fileprivate var didSetupConstraints = false
    open override func updateViewConstraints() {
        #if DEBUG
            log("--- \(self.accessibilityIdentifier) updateViewConstraints")
        #endif
        if (!didSetupConstraints) {
            didSetupConstraints = true
            #if DEBUG
                log("... \(self.accessibilityIdentifier) updateViewConstraints: setupConstraints.")
            #endif
            setupConstraints()
        }
        #if DEBUG
            log("... \(self.accessibilityIdentifier) updateViewConstraints: modifyConstraints.")
        #endif
        modifyConstraints()

        super.updateViewConstraints()
        #if DEBUG
            log("^^^ \(self.accessibilityIdentifier) updateViewConstraints")
        #endif
    }

    open func setupAndComposeView() {
    }
    open func setupConstraints() {
    }
    open func modifyConstraints() {
    }
}


