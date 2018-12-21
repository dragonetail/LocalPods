//
//  TGImage.swift
//  TGImage
//
//  Created by targetcloud on 2017/6/30.
//  Copyright © 2017年 targetcloud. All rights reserved.
//

import UIKit

public enum BorderAlignment {
    case inside
    case center
    case outside
}

public extension UIImage {
    public typealias ContextBlock = (CGContext) -> Void
    
    public class func with(width: CGFloat, height: CGFloat, block: ContextBlock) -> UIImage {
        return self.with(size: CGSize(width: width, height: height), block: block)
    }
    
    public class func with(size: CGSize, opaque: Bool = false, scale: CGFloat = 0, block: ContextBlock) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()!
        block(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    public func with(size: CGSize, opaque: Bool = false, scale: CGFloat = 0, block: ContextBlock) -> UIImage {
        return self + UIImage.with(size:size,opaque:opaque,scale:scale,block:block)
    }
    
    public func with(_ block: ContextBlock) -> UIImage {
        return UIImage.with(size: self.size, opaque: false, scale: self.scale) { context in
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            self.draw(in: rect)
            block(context)
        }
    }
    
    public func with(color: UIColor) -> UIImage {
        return UIImage.with(size: self.size) { context in
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1, y: -1)
            context.setBlendMode(.normal)
            let rect = CGRect(origin: .zero, size: self.size)
            context.clip(to: rect, mask: self.cgImage!)
            color.setFill()
            context.fill(rect)
        }
    }
    
    public class func size(width: CGFloat, height: CGFloat) -> TGImagePresenter {
        return self.size(CGSize(width: width, height: height))
    }
    
    public class func size(_ size: CGSize) -> TGImagePresenter {
        let drawer = TGImagePresenter()
        drawer.size = .fixed(size)
        return drawer
    }
    
    public class func resizable() -> TGImagePresenter {
        let drawer = TGImagePresenter()
        drawer.size = .resizable
        return drawer
    }
    
    private struct AssociatedKeys {
        static var TGImagePositionKey = "TGImagePositionKey"
    }
    
    public var position: CGPoint{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.TGImagePositionKey) as? CGPoint ?? CGPoint.zero
        }
        set(newValue) {
            if self.position != newValue{
                self.willChangeValue(forKey: "position")
                objc_setAssociatedObject(self, &AssociatedKeys.TGImagePositionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.didChangeValue(forKey: "position")
            }
        }
    }
    
    public func position(_ point:CGPoint) -> UIImage{
        self.position = point
        return self
    }
}

extension UIColor{
    public class func randomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
    }
}

public func + (leftImage: UIImage, rigthImage: UIImage) -> UIImage {
    return leftImage.with { context in
        
        let leftRect = CGRect(x: 0, y: 0, width: leftImage.size.width, height: leftImage.size.height)
        var rightRect = CGRect(x: 0, y: 0, width: rigthImage.size.width, height: rigthImage.size.height)
        
        if rigthImage.position.x != 0 || rigthImage.position.y != 0{
            rightRect.origin.x = rigthImage.position.x
            rightRect.origin.y = rigthImage.position.y
        }else if leftRect.contains(rightRect) {
            rightRect.origin.x = (leftRect.size.width - rightRect.size.width) / 2
            rightRect.origin.y = (leftRect.size.height - rightRect.size.height) / 2
        } else {
            rightRect.size = leftRect.size
        }

        rigthImage.draw(in: rightRect)
    }
}

public func += (leftImage:inout UIImage, rigthImage: UIImage) {
    leftImage = leftImage + rigthImage
}

open class TGImagePresenter{
    public enum Size {
        case fixed(CGSize)
        case resizable
    }
    
    fileprivate static let defaultGradientLocations: [CGFloat] = [0, 1]
    fileprivate static let defaultGradientFrom: CGPoint = .zero
    fileprivate static let defaultGradientTo: CGPoint = CGPoint(x: 0, y: 1)
    
    fileprivate var colors: [UIColor] = [.clear]
    fileprivate var colorLocations: [CGFloat] = defaultGradientLocations
    fileprivate var colorStartPoint: CGPoint = defaultGradientFrom
    fileprivate var colorEndPoint: CGPoint = defaultGradientTo
    fileprivate var borderColors: [UIColor] = [.black]
    fileprivate var borderColorLocations: [CGFloat] = defaultGradientLocations
    fileprivate var borderColorStartPoint: CGPoint = defaultGradientFrom
    fileprivate var borderColorEndPoint: CGPoint = defaultGradientTo
    fileprivate var borderWidth: CGFloat = 0
    fileprivate var borderAlignment: BorderAlignment = .inside
    fileprivate var cornerRadiusTopLeft: CGFloat = 0
    fileprivate var cornerRadiusTopRight: CGFloat = 0
    fileprivate var cornerRadiusBottomLeft: CGFloat = 0
    fileprivate var cornerRadiusBottomRight: CGFloat = 0
    
    fileprivate var size: Size = .resizable
    
    private static var cachedImages = [String: UIImage]()
    
    private var cacheKey: String {
        var attributes = [String: String]()
        attributes["colors"] = String(self.colors.description.hashValue)
        attributes["colorLocations"] = String(self.colorLocations.description.hashValue)
        attributes["colorStartPoint"] = String(String(describing: self.colorStartPoint).hashValue)
        attributes["colorEndPoint"] = String(String(describing: self.colorEndPoint).hashValue)
        attributes["borderColors"] = String(self.borderColors.description.hashValue)
        attributes["borderColorLocations"] = String(self.borderColorLocations.description.hashValue)
        attributes["borderColorStartPoint"] = String(String(describing: self.borderColorStartPoint).hashValue)
        attributes["borderColorEndPoint"] = String(String(describing: self.borderColorEndPoint).hashValue)
        attributes["borderWidth"] = String(self.borderWidth.hashValue)
        attributes["borderAlignment"] = String(self.borderAlignment.hashValue)
        attributes["cornerRadiusTopLeft"] = String(self.cornerRadiusTopLeft.hashValue)
        attributes["cornerRadiusTopRight"] = String(self.cornerRadiusTopRight.hashValue)
        attributes["cornerRadiusBottomLeft"] = String(self.cornerRadiusBottomLeft.hashValue)
        attributes["cornerRadiusBottomRight"] = String(self.cornerRadiusBottomRight.hashValue)
        
        switch self.size {
        case .fixed(let size):
            attributes["size"] = "Fixed(\(size.width), \(size.height))"
        case .resizable:
            attributes["size"] = "Resizable"
        }
        
        var serializedAttributes = [String]()
        for key in attributes.keys.sorted() {
            if let value = attributes[key] {
                serializedAttributes.append("\(key):\(value)")
            }
        }
        
        let cacheKey = serializedAttributes.joined(separator: "|")
        return cacheKey
    }
    
    open func color(_ color: UIColor) -> Self {
        self.colors = [color]
        return self
    }
    
    open func color(gradient: [UIColor],locations: [CGFloat] = defaultGradientLocations,from startPoint: CGPoint = defaultGradientFrom,to endPoint: CGPoint = defaultGradientTo) -> Self {
        self.colors = gradient
        self.colorLocations = locations
        self.colorStartPoint = startPoint
        self.colorEndPoint = endPoint
        return self
    }
    
    open func border(color: UIColor) -> Self {
        self.borderColors = [color]
        return self
    }
    
    open func border(gradient: [UIColor],locations: [CGFloat] = defaultGradientLocations,from startPoint: CGPoint = defaultGradientFrom,to endPoint: CGPoint = defaultGradientTo
        ) -> Self {
        self.borderColors = gradient
        self.borderColorLocations = locations
        self.borderColorStartPoint = startPoint
        self.borderColorEndPoint = endPoint
        return self
    }
    
    open func border(width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }
    
    open func border(alignment: BorderAlignment) -> Self {
        self.borderAlignment = alignment
        return self
    }
    
    open func corner(radius: CGFloat) -> Self {
        return self.corner(topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius)
    }
    
    open func corner(topLeft: CGFloat) -> Self {
        self.cornerRadiusTopLeft = topLeft
        return self
    }
    
    open func corner(topRight: CGFloat) -> Self {
        self.cornerRadiusTopRight = topRight
        return self
    }
    
    open func corner(bottomLeft: CGFloat) -> Self {
        self.cornerRadiusBottomLeft = bottomLeft
        return self
    }
    
    open func corner(bottomRight: CGFloat) -> Self {
        self.cornerRadiusBottomRight = bottomRight
        return self
    }
    
    open func corner(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) -> Self {
        return self.corner(topLeft: topLeft).corner(topRight: topRight).corner(bottomLeft: bottomLeft).corner(bottomRight: bottomRight)
    }
    
    open var image: UIImage {
        switch self.size {
        case .fixed(let size):
            return self.imageWithSize(size)
        case .resizable:
            self.borderAlignment = .inside
            let cornerRadius = max(self.cornerRadiusTopLeft, self.cornerRadiusTopRight,self.cornerRadiusBottomLeft, self.cornerRadiusBottomRight)
            let capSize = ceil(max(cornerRadius, self.borderWidth))
            let imageSize = capSize * 2 + 1
            let image = self.imageWithSize(CGSize(width: imageSize, height: imageSize))
            let capInsets = UIEdgeInsets(top: capSize, left: capSize, bottom: capSize, right: capSize)
            return image.resizableImage(withCapInsets: capInsets)
        }
    }
    
    private func imageWithSize(_ size: CGSize, useCache: Bool = true) -> UIImage {
        if let cachedImage = type(of: self).cachedImages[self.cacheKey], useCache {
            return cachedImage
        }
        
        var imageSize = CGSize(width: size.width, height: size.height)
        var rect = CGRect()
        rect.size = imageSize
        
        switch self.borderAlignment {
        case .inside:
            rect.origin.x += self.borderWidth / 2
            rect.origin.y += self.borderWidth / 2
            rect.size.width -= self.borderWidth
            rect.size.height -= self.borderWidth
        case .center:
            rect.origin.x += self.borderWidth / 2
            rect.origin.y += self.borderWidth / 2
            imageSize.width += self.borderWidth
            imageSize.height += self.borderWidth
        case .outside:
            rect.origin.x += self.borderWidth / 2
            rect.origin.y += self.borderWidth / 2
            rect.size.width += self.borderWidth
            rect.size.height += self.borderWidth
            imageSize.width += self.borderWidth * 2
            imageSize.height += self.borderWidth * 2
        }
        
        let cornerRadius = max(self.cornerRadiusTopLeft, self.cornerRadiusTopRight,self.cornerRadiusBottomLeft, self.cornerRadiusBottomRight)
        
        let image = UIImage.with(size: imageSize) { context in
            let path: UIBezierPath
            if self.cornerRadiusTopLeft == self.cornerRadiusTopRight && self.cornerRadiusTopLeft == self.cornerRadiusBottomLeft && self.cornerRadiusTopLeft == self.cornerRadiusBottomRight && self.cornerRadiusTopLeft > 0 {
                path = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadiusTopLeft)
            } else if cornerRadius > 0 {
                let startAngle = CGFloat.pi
                let topLeftCenter = CGPoint(x: self.cornerRadiusTopLeft + self.borderWidth / 2,y: self.cornerRadiusTopLeft + self.borderWidth / 2)
                let topRightCenter = CGPoint(x: imageSize.width - self.cornerRadiusTopRight - self.borderWidth / 2,y: self.cornerRadiusTopRight + self.borderWidth / 2)
                let bottomRightCenter = CGPoint(x: imageSize.width - self.cornerRadiusBottomRight - self.borderWidth / 2,y: imageSize.height - self.cornerRadiusBottomRight - self.borderWidth / 2)
                let bottomLeftCenter = CGPoint(x: self.cornerRadiusBottomLeft + self.borderWidth / 2,y: imageSize.height - self.cornerRadiusBottomLeft - self.borderWidth / 2)
                let mutablePath = UIBezierPath()
                self.cornerRadiusTopLeft > 0 ? mutablePath.addArc(withCenter: topLeftCenter,radius: self.cornerRadiusTopLeft,startAngle: startAngle,endAngle: 1.5 * startAngle,clockwise: true) : mutablePath.move(to: topLeftCenter)
                self.cornerRadiusTopRight > 0 ? mutablePath.addArc(withCenter: topRightCenter,radius: self.cornerRadiusTopRight,startAngle: 1.5 * startAngle,endAngle: 2 * startAngle,clockwise: true) : mutablePath.addLine(to: topRightCenter)
                self.cornerRadiusBottomRight > 0 ? mutablePath.addArc(withCenter: bottomRightCenter,radius: self.cornerRadiusBottomRight,startAngle: 2 * startAngle,endAngle: 2.5 * startAngle,clockwise: true) : mutablePath.addLine(to: bottomRightCenter)
                self.cornerRadiusBottomLeft > 0 ? mutablePath.addArc(withCenter: bottomLeftCenter,radius: self.cornerRadiusBottomLeft,startAngle: 2.5 * startAngle,endAngle: 3 * startAngle,clockwise: true) : mutablePath.addLine(to: bottomLeftCenter)
                self.cornerRadiusTopLeft > 0 ? mutablePath.addLine(to: CGPoint(x: self.borderWidth / 2, y: topLeftCenter.y)) : mutablePath.addLine(to: topLeftCenter)
                path = mutablePath
            }
            else {
                path = UIBezierPath(rect: rect)
            }
            
            context.saveGState()
            if self.colors.count <= 1 {
                self.colors.first?.setFill()
                path.fill()
            } else {
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let colors = self.colors.map { $0.cgColor } as CFArray
                if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: self.colorLocations) {
                    let startPoint = CGPoint(x: self.colorStartPoint.x * imageSize.width,y: self.colorStartPoint.y * imageSize.height)
                    let endPoint = CGPoint(x: self.colorEndPoint.x * imageSize.width,y: self.colorEndPoint.y * imageSize.height)
                    context.addPath(path.cgPath)
                    context.clip()
                    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
                }
            }
            context.restoreGState()
            
            context.saveGState()
            if self.borderColors.count <= 1 {
                self.borderColors.first?.setStroke()
                path.lineWidth = self.borderWidth
                path.stroke()
            } else {
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let colors = self.borderColors.map { $0.cgColor } as CFArray
                if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: self.borderColorLocations) {
                    let startPoint = CGPoint(x: self.borderColorStartPoint.x * imageSize.width,y: self.borderColorStartPoint.y * imageSize.height)
                    let endPoint = CGPoint(x: self.borderColorEndPoint.x * imageSize.width,y: self.borderColorEndPoint.y * imageSize.height)
                    context.addPath(path.cgPath)
                    context.setLineWidth(self.borderWidth)
                    context.replacePathWithStrokedPath()
                    context.clip()
                    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
                }
            }
            context.restoreGState()
        }

        if useCache {
            type(of: self).cachedImages[self.cacheKey] = image
        }
        return image
    }
}
