//
//  BaseViewWithAutolayout.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/13.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

open class BaseViewWithAutolayout: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _ = self.autoLayout("BaseView")
        #if DEBUG
            print("--- \(self.accessibilityIdentifier ?? "") init")
        #endif

        #if DEBUG
            print("... \(self.accessibilityIdentifier ?? "") init: setupAndComposeView")
        #endif
        setupAndComposeView()

        // bootstrap Auto Layout
        self.setNeedsUpdateConstraints()
        #if DEBUG
            print("^^^ \(self.accessibilityIdentifier ?? "") init")
        #endif
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate var didSetupConstraints = false
    open override func updateConstraints() {
        #if DEBUG
            print("--- \(self.accessibilityIdentifier ?? "") updateConstraints")
        #endif
        if (!didSetupConstraints) {
            didSetupConstraints = true
            #if DEBUG
                print("... \(self.accessibilityIdentifier ?? "") updateConstraints: setupConstraints.")
            #endif
            setupConstraints()
        }
        #if DEBUG
            print("... \(self.accessibilityIdentifier ?? "") updateConstraints: modifyConstraints.")
        #endif
        modifyConstraints()

        super.updateConstraints()
        #if DEBUG
            print("^^^ \(self.accessibilityIdentifier ?? "") updateConstraints")
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
                print("")
                print("...... \(self.accessibilityIdentifier ?? "") autoPrintViewLayoutTrace ......")
                print(self.value(forKey: "_autolayoutTrace") ?? "")
                print("")
            }
            if autoPrintAll || autoPrintSelfViewConstraints {
                print("")
                print("...... \(self.accessibilityIdentifier ?? "") autoPrintSelfViewConstraints ......")
                self.autoPrintConstraints()
                print("")
            }
            if autoPrintAll || autoPrintSuperViewConstraints {
                print("")
                print("...... \(self.accessibilityIdentifier ?? "") autoPrintSuperViewConstraints ......")
                self.superview?.autoPrintConstraints()
                print("")
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

