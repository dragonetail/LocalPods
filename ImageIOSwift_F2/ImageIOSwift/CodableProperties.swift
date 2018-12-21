//
//  CodableProperties.swift
//  ATGMediaBrowser
//
//  Created by 孙玉新 on 2018/12/9.
//

import Foundation

public struct CodableProperty: Codable {
    public var s: String? // For String, Data, Unknown value
    public var i: Int?
    public var r: Double?
    public var a: [CodableProperty]?
    public var d: [String: CodableProperty]?
}

public struct CodableImageProperties: Codable {
    public var codableValue: [String: CodableProperty]

    public init(rawValue: [CFString: Any]) {
        codableValue = CodableImageProperties.convert(rawValue: rawValue)
//
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let encodedData = try encoder.encode(codableValue)
//            let jsonString = String(data: encodedData, encoding: .utf8)
//            print(jsonString!)
//        } catch {
//            print("Error")
//        }
    }

    static func convert(rawValue: [CFString: Any]) -> [String: CodableProperty] {
        var codableValue = [String: CodableProperty]()

        rawValue.forEach { (key: CFString, value: Any) in
            let strKey = String(key)
            let propValue = CodableImageProperties.convert(key: strKey, value: value)
            codableValue[strKey] = propValue
        }
        return codableValue
    }

    static func convert(key: String, value: Any) -> CodableProperty {
        //let valueType = type(of: value)
        switch value {
        case let str as String:
            //print("\(key): String(\(valueType)) : \(str)")
            return CodableProperty(s: String(str), i: nil, r: nil, a: nil, d: nil)
        case let iv as Int:
            //print("\(key): Int(\(valueType)) : \(iv)")
            return CodableProperty(s: nil, i: iv, r: nil, a: nil, d: nil)
        case let dv as Double:
            //print("\(key): Double(\(valueType)) : \(dv)")
            return CodableProperty(s: nil, i: nil, r: dv, a: nil, d: nil)
        case let number as NSNumber:
            //print("\(key): Number(\(valueType)) : \(number)")
            return CodableProperty(s: nil, i: Int(truncating: number), r: nil, a: nil, d: nil)
        case let dict as [CFString: Any]:
            //print("\(key): NSDictionary(\(valueType))")
            return CodableProperty(s: nil, i: nil, r: nil, a: nil, d: convert(rawValue: dict))
        case let arrValue as NSArray:
            //print("\(key): NSArray(\(valueType))")
            let arr: [CodableProperty] = arrValue.map { (subValue) -> CodableProperty in
                return CodableImageProperties.convert(key: key, value: subValue)
            }
            return CodableProperty(s: nil, i: nil, r: nil, a: arr, d: nil)
        case let data as NSData:
            //print("\(key): NSData(\(valueType))")
            return CodableProperty(s: String(describing: data), i: nil, r: nil, a: nil, d: nil)
        default:
            //print("??????? : UNKOWN TYPE : \(key):  \(valueType)")
            return CodableProperty(s: String(describing: value), i: nil, r: nil, a: nil, d: nil)
        }
    }
}





