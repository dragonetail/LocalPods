//
//  Int+Extension.swift
//  PhotoSaver
//
//  Created by dragonetail on 2018/12/16.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import Foundation

extension Int {

    static var extDefaultFormatter: NumberFormatter = {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal

        return formater
    }()

   public func extFormat(_ groupingSeparator: String? = nil) -> String? {
        if let groupingSeparator = groupingSeparator {
            let formater = NumberFormatter()
            formater.groupingSeparator = groupingSeparator
            formater.numberStyle = .decimal
            return formater.string(from: NSNumber(value: self))
        } else {
            return Int.extDefaultFormatter.string(from: NSNumber(value: self))
        }
    }
}

