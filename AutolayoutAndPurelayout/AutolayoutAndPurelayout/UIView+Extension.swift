//
//  UIView+Extension.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/13.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

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
    
    func roundBorder(_ color: UIColor = UIColor.purple) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        layer.cornerRadius = 3
        clipsToBounds = true
    }
}
