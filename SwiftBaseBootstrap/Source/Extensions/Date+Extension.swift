//
//  Date_Extension.swift
//  PhotoSaver
//
//  Created by dragonetail on 2018/12/16.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import Foundation


extension Date {
    static var extShortDateFormatter: DateFormatter = {
        //Ref: http://nsdateformatter.com/
        //guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdEEEE", options: 0, locale: Locale(identifier: "zh_CN"))
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdEEEE", options: 0, locale: Locale.current)
            else { fatalError() }
        //print(formatString)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatString

        return dateFormatter
    }()

    public var extShortDate: String{
        return Date.extShortDateFormatter.string(from: self)
    }

    static var extFullDateFormatter: DateFormatter = {
        //Ref: http://nsdateformatter.com/
        //guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdEEEE", options: 0, locale: Locale(identifier: "zh_CN"))
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdyyyyEEEE", options: 0, locale: Locale.current)
            else { fatalError() }
        //print(formatString)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatString

        return dateFormatter
    }()
    
    public var extFullDate: String {
        return Date.extFullDateFormatter.string(from: self)
    }

    static var extFullDatetimeFormatter: DateFormatter = {
        //Ref: http://nsdateformatter.com/
        //guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdEEEE", options: 0, locale: Locale(identifier: "zh_CN"))
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdyyyyEEEEHHmm", options: 0, locale: Locale.current)
            else { fatalError() }
        //print(formatString)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatString

        return dateFormatter
    }()
    
    public var extFullDatetime: String {
        return Date.extFullDatetimeFormatter.string(from: self)
    }
}
