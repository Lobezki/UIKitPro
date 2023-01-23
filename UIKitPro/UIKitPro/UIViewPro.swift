//
//  UIViewPro.swift
//  UIKitPro
//
//  Created by Кирилл Сурело on 19.02.2022.
//

import UIKit
import QuartzCore

public enum UIBezierPathShape {
    case rect, roundedRect, roundedRectByRoundingCorners, oval
}

public enum UIViewShadow: Int {
    case none, inner, outer
}

public enum UIViewBackground: Int {
    case solid, gradient
}

@IBDesignable class UIViewPro: UIView {
    
    private static var _path: UIBezierPath!
    private static var _bgSolidLayer: CALayer = CALayer()
    private static var _bgGradientLayer: CAGradientLayer = CAGradientLayer()
    private static var _borderLayer: CAShapeLayer = CAShapeLayer()
    private static var _viewMask: CAShapeLayer = CAShapeLayer()
    private static var _backgroundType: UIViewBackground = .solid
    private static var _backgroundColor: UIColor = UIColor.white
    private static var _gradientColor: UIColor = UIColor.black
    private static var _innerShadowLayer: CALayer = CALayer()
    private static var _shadowType: UIViewShadow = .none
    private static var _shadowPath: UIBezierPath!
    private static var _shadowColor: UIColor = UIColor.black
    private static var _shadowOpacity: Float = 1.0
    private static var _shadowSmooth: CGFloat = 1.0
    private static var _shadowOffset: CGSize = CGSize(width: 0, height: 0)
    private static var _corners: UIRectCorner = UIRectCorner(arrayLiteral: .allCorners)
    private static var _cornerRadius: CGFloat = 0.0
//    private static var _borderType
    private static var _borderWidth: CGFloat = 0.0
    private static var _borderColor: UIColor = UIColor.black
    
    @IBInspectable var cornerRadius: CGFloat {
        set(value) {
            UIViewPro._cornerRadius = value
            configView()
        }
        get {
            return UIViewPro._cornerRadius
        }
    }

    @IBInspectable var topLeft: Bool {
        set(value) {
            if value {
                UIViewPro._corners.update(with: .topLeft)
            } else {
                UIViewPro._corners.remove(.topLeft)
            }
            configView()
        }
        get {
            UIViewPro._corners = UIRectCorner(arrayLiteral: .topLeft)
            return true
        }
    }

    @IBInspectable var topRight: Bool {
        set(value) {
            if value {
                UIViewPro._corners.update(with: .topRight)
            } else {
                UIViewPro._corners.remove(.topRight)
            }
            configView()
        }
        get {
            UIViewPro._corners = UIRectCorner(arrayLiteral: .topRight)
            return true
        }
    }

    @IBInspectable var bottomLeft: Bool {
        set(value) {
            if value {
                UIViewPro._corners.update(with: .bottomLeft)
            } else {
                UIViewPro._corners.remove(.bottomLeft)
            }
            configView()
        }
        get {
            UIViewPro._corners = UIRectCorner(arrayLiteral: .bottomLeft)
            return true
        }
    }

    @IBInspectable var bottomRight: Bool {
        set(value) {
            if value {
                UIViewPro._corners.update(with: .bottomRight)
            } else {
                UIViewPro._corners.remove(.bottomRight)
            }
            configView()
        }
        get {
            UIViewPro._corners = UIRectCorner(arrayLiteral: .bottomRight)
            return true
        }
    }
    
//    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'backgroundType' instead.")
    @IBInspectable var background: Int {
        set(value) {
            UIViewPro._backgroundType = UIViewBackground(rawValue: value) ?? .solid
            configView()
        }
        get {
            return 0
        }
    }
    
    @IBInspectable var mainColor: UIColor {
        set(value) {
            UIViewPro._backgroundColor = value
            configView()
        }
        get {
            return UIViewPro._backgroundColor
        }
    }
    
    @IBInspectable var gradientColor: UIColor {
        set(value) {
            UIViewPro._gradientColor = value
            configView()
        }
        get {
            return UIViewPro._gradientColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set(value) {
            UIViewPro._borderWidth = value
            configView()
        }
        get {
            return UIViewPro._borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set(value) {
            UIViewPro._borderColor = value
            configView()
        }
        get {
            return UIViewPro._borderColor
        }
    }
//    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'shadowType' instead.")
    @IBInspectable var shadow: Int {
        set(value) {
            UIViewPro._shadowType = UIViewShadow(rawValue: value) ?? .none
            configView()
        }
        get {
            return 0
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        set(value) {
            UIViewPro._shadowColor = value
            configView()
        }
        get {
            return UIViewPro._shadowColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set(value) {
            UIViewPro._shadowOpacity = value
            configView()
        }
        get {
            return UIViewPro._shadowOpacity
        }
    }
    
    @IBInspectable var shadowSmooth: CGFloat {
        set(value) {
            UIViewPro._shadowSmooth = value
            configView()
        }
        get {
            return UIViewPro._shadowSmooth
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set(value) {
            UIViewPro._shadowOffset = value
            configView()
        }
        get {
            return UIViewPro._shadowOffset
        }
    }
    
    // MARK: General view methods
    
    private func configView() {
        
        if UIViewPro._cornerRadius > 0 {
            configViewPath(shape: .roundedRectByRoundingCorners)
        } else {
            configViewPath(shape: .rect)
        }

        switch UIViewPro._backgroundType {

        case .solid:
            configSolidBackground()
        case .gradient:
            configGradientBackground()
        }

        if UIViewPro._cornerRadius > 0 {
            configShadowPath(shape: .roundedRectByRoundingCorners)
        } else {
            configShadowPath(shape: .rect)
        }

        switch UIViewPro._shadowType {

        case .none:
            removeInnerShadow()
            removeOuterShadow()
        case .inner:
            removeOuterShadow()
            addInnerShadow()
        case .outer:
            removeInnerShadow()
            addOuterShadow()
        }
        
        configBorder()
    }
    
    private func configViewPath(shape: UIBezierPathShape) {

        switch shape {
        case .rect:
            UIViewPro._path = UIBezierPath(
                rect: bounds)
        default:
            UIViewPro._path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: UIRectCorner(arrayLiteral: UIViewPro._corners),
                cornerRadii: CGSize(
                    width: UIViewPro._cornerRadius,
                    height: UIViewPro._cornerRadius)
            )
        }
    }
    
//    private func addViewMask() {
//        let mask = CAShapeLayer()
//        mask.path = UIViewPro._path.cgPath
//        layer.mask = mask
//    }
    
    private func configViewMask() {
        let mask = CAShapeLayer()
        mask.path = UIViewPro._path.cgPath
//        UIViewPro._viewMask = mask
    }
    
    private func removeViewMask() {
        layer.mask = nil
    }
    
    // MARK: Inner shadow methods
    
    private func addInnerShadow() {
        removeInnerShadow()
        UIViewPro._innerShadowLayer.frame = bounds
        configInnerShadow()
        addInnerShadowMask()
//        layer.addSublayer(UIViewPro._innerShadowLayer)
        layer.insertSublayer(UIViewPro._innerShadowLayer, above: UIViewPro._bgSolidLayer)
//        addViewMask()
    }

    private func removeInnerShadow() {
        UIViewPro._innerShadowLayer.removeFromSuperlayer()
        removeViewMask()
    }
    
    // MARK: Outer shadow methods
    
    private func addOuterShadow() {
        layer.shadowPath = UIViewPro._path.cgPath
        layer.shadowColor = UIViewPro._shadowColor.cgColor
        layer.shadowOpacity = UIViewPro._shadowOpacity
        layer.shadowOffset = UIViewPro._shadowOffset
        layer.shadowRadius = UIViewPro._shadowSmooth
//        layer.rasterizationScale =  UIScreen.main.scale
    }

    private func removeOuterShadow() {
        layer.shadowOpacity = 0
    }
    
    private func configShadowPath(shape: UIBezierPathShape) {

        switch shape {
        case .rect:
            UIViewPro._shadowPath = UIBezierPath(
                rect: bounds).reversing()
        default:
            UIViewPro._shadowPath = UIBezierPath(
                roundedRect: UIViewPro._innerShadowLayer.bounds.insetBy(
                    dx: -UIViewPro._shadowOffset.width - 4,
                    dy: -UIViewPro._shadowOffset.height - 4
                ),
                byRoundingCorners: UIRectCorner(arrayLiteral: UIViewPro._corners),
                cornerRadii: CGSize(
                    width: UIViewPro._cornerRadius,
                    height: UIViewPro._cornerRadius)
            ).reversing()
        }
        
        UIViewPro._shadowPath.append(UIViewPro._path)
    }

    private func configInnerShadow() {
        UIViewPro._innerShadowLayer.shadowPath = UIViewPro._shadowPath.cgPath
        UIViewPro._innerShadowLayer.shadowColor = UIViewPro._shadowColor.cgColor
        UIViewPro._innerShadowLayer.shadowOffset = UIViewPro._shadowOffset
        UIViewPro._innerShadowLayer.shadowOpacity = UIViewPro._shadowOpacity
//        UIViewPro._innerShadow.shouldRasterize = false
//        UIViewPro._innerShadow.rasterizationScale = UIScreen.main.scale
        UIViewPro._innerShadowLayer.shadowRadius = UIViewPro._shadowSmooth
    }

    private func addInnerShadowMask() {
        let mask = CAShapeLayer()
        mask.path = UIViewPro._path.cgPath
        UIViewPro._innerShadowLayer.mask = mask
    }
    
    // MARK: Background methods
    
    private func configSolidBackground() {
        UIViewPro._bgSolidLayer.removeFromSuperlayer()
        UIViewPro._bgGradientLayer.removeFromSuperlayer()
        backgroundColor = .clear

        let mask = CAShapeLayer()
        mask.path = UIViewPro._path.cgPath

        UIViewPro._bgSolidLayer.frame = bounds
        UIViewPro._bgSolidLayer.mask = mask
        UIViewPro._bgSolidLayer.backgroundColor = UIViewPro._backgroundColor.cgColor
        layer.insertSublayer(UIViewPro._bgSolidLayer, at: 0)
    }
    
    private func configGradientBackground() {
        UIViewPro._bgSolidLayer.removeFromSuperlayer()
        UIViewPro._bgGradientLayer.removeFromSuperlayer()
        
        let mask = CAShapeLayer()
        mask.path = UIViewPro._path.cgPath
        
        UIViewPro._bgGradientLayer.frame = bounds
        UIViewPro._bgGradientLayer.mask = mask
        UIViewPro._bgGradientLayer.colors = [
            UIViewPro._backgroundColor.cgColor,
            UIViewPro._gradientColor.cgColor
        ]
        layer.insertSublayer(UIViewPro._bgGradientLayer, at: 0)
    }
    
    // MARK: Border methods
    
    private func configBorder() {

        let mask = CAShapeLayer()
        mask.path = UIViewPro._path.cgPath
        
        UIViewPro._borderLayer.frame = bounds
        UIViewPro._borderLayer.mask = mask
        UIViewPro._borderLayer.path = UIViewPro._path.cgPath
        UIViewPro._borderLayer.fillColor = UIColor.clear.cgColor
        UIViewPro._borderLayer.strokeColor = UIViewPro._borderColor.cgColor
        UIViewPro._borderLayer.lineWidth = UIViewPro._borderWidth * 2
        
        layer.addSublayer(UIViewPro._borderLayer)
    }
    
    // MARK: Super methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .redraw
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configView()
    }
}
