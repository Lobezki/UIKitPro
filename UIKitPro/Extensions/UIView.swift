////
////  UIView.swift
////  UIKitPro
////
////  Created by Кирилл Сурело on 18.02.2022.
////
//
//import UIKit
//import QuartzCore
//
//@IBDesignable extension UIView {
//    private static var _path: UIBezierPath!
//    private static var _backgroundLayer = CALayer()
//    private static var _innerShadowLayer = CALayer()
//    private static var _shadowType: ShadowType = .none
//    private static var _shadowPath: UIBezierPath!
//    private static var _shadowColor: UIColor = .black
//    private static var _shadowOpacity: Float = 1.0
//    private static var _shadowSmooth: CGFloat = 1.0
//    private static var _shadowOffset: CGSize = CGSize(width: 0, height: 0)
////    private static var _outerShadowColor: UIColor = .black
////    private static var _outerShadowOpacity: Float = 1.0
////    private static var _outerShadowSmooth: CGFloat = 1.0
////    private static var _outerShadowOffset: CGSize = CGSize(width: 0, height: 0)
//    private static var _corners: UIRectCorner = UIRectCorner(arrayLiteral: .allCorners)
//    private static var _cornerRadius: CGFloat = 0.0
//
//    @IBInspectable var cornerRadius: CGFloat {
//        set(value) {
//            UIView._cornerRadius = value
//            configView()
//        }
//        get {
//            return UIView._cornerRadius
//        }
//    }
//
//    @IBInspectable var topLeft: Bool {
//        set(value) {
//            if value {
//                UIView._corners.update(with: .topLeft)
//            } else {
//                UIView._corners.remove(.topLeft)
//            }
//            configView()
//        }
//        get {
//            UIView._corners = UIRectCorner(arrayLiteral: .topLeft)
//            return true
//        }
//    }
//
//    @IBInspectable var topRight: Bool {
//        set(value) {
//            if value {
//                UIView._corners.update(with: .topRight)
//            } else {
//                UIView._corners.remove(.topRight)
//            }
//            configView()
//        }
//        get {
//            UIView._corners = UIRectCorner(arrayLiteral: .topRight)
//            return true
//        }
//    }
//
//    @IBInspectable var bottomLeft: Bool {
//        set(value) {
//            if value {
//                UIView._corners.update(with: .bottomLeft)
//            } else {
//                UIView._corners.remove(.bottomLeft)
//            }
//            configView()
//        }
//        get {
//            UIView._corners = UIRectCorner(arrayLiteral: .bottomLeft)
//            return true
//        }
//    }
//
//    @IBInspectable var bottomRight: Bool {
//        set(value) {
//            if value {
//                UIView._corners.update(with: .bottomRight)
//            } else {
//                UIView._corners.remove(.bottomRight)
//            }
//            configView()
//        }
//        get {
//            UIView._corners = UIRectCorner(arrayLiteral: .bottomRight)
//            return true
//        }
//    }
//    
//    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'shadowType' instead.")
//    @IBInspectable var shadow: Int {
//        set(value) {
//            UIView._shadowType = ShadowType(rawValue: value) ?? .none
//            configView()
//        }
//        get {
//            return 0
//        }
//    }
//    
//    @IBInspectable var shadowColor: UIColor {
//        set(value) {
//            UIView._shadowColor = value
//            configView()
//        }
//        get {
//            return UIView._shadowColor
//        }
//    }
//    
//    @IBInspectable var shadowOpacity: Float {
//        set(value) {
//            UIView._shadowOpacity = value
//            configView()
//        }
//        get {
//            return UIView._shadowOpacity
//        }
//    }
//    
//    @IBInspectable var shadowSmooth: CGFloat {
//        set(value) {
//            UIView._shadowSmooth = value
//            configView()
//        }
//        get {
//            return UIView._shadowSmooth
//        }
//    }
//    
//    @IBInspectable var shadowOffset: CGSize {
//        set(value) {
//            UIView._shadowOffset = value
//            configView()
//        }
//        get {
//            return UIView._shadowOffset
//        }
//    }
//
////    @IBInspectable var outerShadow: Bool {
////        set(value) {
////            if value {
////                configView()
////            }
////            else {
////               // removeOuterShadow()
////           }
////        }
////        get {
////            return false
////        }
////    }
//
//    // MARK: Inner shadow methods
//    private func addInnerShadow() {
//        UIView._innerShadowLayer.frame = bounds
//        configInnerShadow()
//        removeInnerShadow()
//        layer.addSublayer(UIView._innerShadowLayer)
//    }
//
//    private func removeInnerShadow() {
//        UIView._innerShadowLayer.removeFromSuperlayer()
//    }
//    
//    // MARK: Outer shadow methods
//    private func addOuterShadow() {
//        layer.shadowPath = UIView._path.cgPath
//        layer.shadowColor = UIView._shadowColor.cgColor
//        layer.shadowOpacity = UIView._shadowOpacity
////        layer.shadowOffset = UIView._outerShadowOffset
//        layer.shadowOffset = UIView._shadowOffset
//        layer.shadowRadius = UIView._shadowSmooth
////        layer.rasterizationScale =  UIScreen.main.scale
//    }
//
//    private func removeOuterShadow() {
//        layer.shadowOpacity = 0
//    }
//
//    private func configViewPath(shape: UIBezierPathShape) {
//
//        switch shape {
//        case .rect:
//            UIView._path = UIBezierPath(
//                rect: bounds)
//        default:
//            UIView._path = UIBezierPath(
//                roundedRect: bounds,
//                byRoundingCorners: UIRectCorner(arrayLiteral: UIView._corners),
//                cornerRadii: CGSize(
//                    width: UIView._cornerRadius,
//                    height: UIView._cornerRadius)
//            )
//        }
//    }
//    
//    private func configShadowPath(shape: UIBezierPathShape) {
//
//        switch shape {
//        case .rect:
//            UIView._shadowPath = UIBezierPath(
//                rect: bounds).reversing()
//        default:
//            UIView._shadowPath = UIBezierPath(
//                roundedRect: UIView._innerShadowLayer.bounds.insetBy(
//                    dx: -UIView._shadowOffset.width - 4,
//                    dy: -UIView._shadowOffset.height - 4
//                ),
//                byRoundingCorners: UIRectCorner(arrayLiteral: UIView._corners),
//                cornerRadii: CGSize(
//                    width: UIView._cornerRadius,
//                    height: UIView._cornerRadius)
//            ).reversing()
//        }
//        
//        UIView._shadowPath.append(UIView._path)
//    }
//
//    private func configInnerShadow() {
//        UIView._innerShadowLayer.shadowPath = UIView._shadowPath.cgPath
//        UIView._innerShadowLayer.shadowColor = UIView._shadowColor.cgColor
//        UIView._innerShadowLayer.shadowOffset = UIView._shadowOffset
//        UIView._innerShadowLayer.shadowOpacity = UIView._shadowOpacity
////        UIView._innerShadow.shouldRasterize = false
////        UIView._innerShadow.rasterizationScale = UIScreen.main.scale
//        UIView._innerShadowLayer.shadowRadius = UIView._shadowSmooth
//    }
//
////    private func configInnerShadowMask() {
////        let mask = CAShapeLayer()
////        mask.path = UIView._path.cgPath
////        UIView._innerShadowLayer.mask = mask
////    }
//    
//    private func setViewMask() {
//        let mask = CAShapeLayer()
//        mask.path = UIView._path.cgPath
//        layer.mask = mask
//    }
////
////    private func configBackground() {
////        UIView._backgroundLayer.removeFromSuperlayer()
////        let bgColor:UIColor = .lightGray
////        backgroundColor = .clear
////
////        let mask = CAShapeLayer()
////        mask.path = UIView._path.cgPath
////
////        UIView._backgroundLayer.frame = bounds
////        UIView._backgroundLayer.mask = mask
////        UIView._backgroundLayer.backgroundColor = bgColor.cgColor
////        layer.addSublayer(UIView._backgroundLayer)
////    }
//    
//    private func configView() {
//        
//        if UIView._cornerRadius > 0 {
//            configViewPath(shape: .roundedRectByRoundingCorners)
//        } else {
//            configViewPath(shape: .rect)
//        }
//        
////        configBackground()
//        
//        if UIView._cornerRadius > 0 {
//            configShadowPath(shape: .roundedRectByRoundingCorners)
//        } else {
//            configShadowPath(shape: .rect)
//        }
//        
//        switch UIView._shadowType {
//            
//        case .none:
//            removeInnerShadow()
//            removeOuterShadow()
//        case .inner:
//            addInnerShadow()
//        case .outer:
//            addOuterShadow()
//        }
//        layer.masksToBounds = UIView._cornerRadius > 0
////        setViewMask()
//    }
//}
