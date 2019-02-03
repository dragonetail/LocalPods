//
//  BaseViewWithAutolayout.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/13.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

open class BaseViewWithAutolayout: UIView {

    #if DEBUG
        var debugOutputEnable = true
        fileprivate func log(_ msg: String) {
            if debugOutputEnable {
                print(msg)
            }
        }
    #endif

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoLayout("BaseView")
        #if DEBUG
            log("--- \(self.accessibilityIdentifier ?? "") init")
        #endif

        #if DEBUG
            log("... \(self.accessibilityIdentifier ?? "") init: setupAndComposeView")
        #endif
        setupAndComposeView()

        // bootstrap Auto Layout
        self.setNeedsUpdateConstraints()
        #if DEBUG
            log("^^^ \(self.accessibilityIdentifier ?? "") init")
        #endif
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate var didSetupConstraints = false
    open override func updateConstraints() {
        #if DEBUG
            log("--- \(self.accessibilityIdentifier ?? "") updateConstraints")
        #endif
        if (!didSetupConstraints) {
            didSetupConstraints = true
            #if DEBUG
                log("... \(self.accessibilityIdentifier ?? "") updateConstraints: setupConstraints.")
            #endif
            setupConstraints()
        }
        #if DEBUG
            log("... \(self.accessibilityIdentifier ?? "") updateConstraints: modifyConstraints.")
        #endif
        modifyConstraints()

        super.updateConstraints()
        #if DEBUG
            log("^^^ \(self.accessibilityIdentifier ?? "") updateConstraints")
        #endif
    }

    #if DEBUG
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
        open override func layoutSubviews() {
            super.layoutSubviews()

            if autoPrintAll || autoPrintViewLayoutTrace {
                log("")
                log("...... \(self.accessibilityIdentifier ?? "") autoPrintViewLayoutTrace ......")
                log(String(describing: self.value(forKey: "_autolayoutTrace")))
                log("")
            }
            if autoPrintAll || autoPrintSelfViewConstraints {
                log("")
                log("...... \(self.accessibilityIdentifier ?? "") autoPrintSelfViewConstraints ......")
                self.autoPrintConstraints()
                log("")
            }
            if autoPrintAll || autoPrintSuperViewConstraints {
                log("")
                log("...... \(self.accessibilityIdentifier ?? "") autoPrintSuperViewConstraints ......")
                self.superview?.autoPrintConstraints()
                log("")
            }
        }
    #endif
    // Should overritted by subclass, setup view and compose subviews
    open func setupAndComposeView() {
    }
    // invoked only once
    open func setupConstraints() {
    }
    open func modifyConstraints() {
    }
}

