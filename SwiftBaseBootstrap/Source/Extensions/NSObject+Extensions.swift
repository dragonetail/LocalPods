//
//  BaseViewWithAutolayout.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/13.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

extension NSObject {
    var extClassName: String {
        get {
            let name = type(of: self).description()
            if(name.contains(".")) {
                return name.components(separatedBy: ".")[1];
            } else {
                return name;
            }

        }
    }
    
    var extClassFullName: String {
        get {
            return  type(of: self).description()
        }
    }
}
