//
//  UIViewExtensions.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit

extension UIView {
    private class func viewInNibNamed<T: UIView>(_ nibNamed: String) -> T {
        return Bundle.main.loadNibNamed(nibNamed, owner: nil, options: nil)!.first as! T
    }

    class func nib() -> Self {
        return viewInNibNamed(nameOfClass)
    }

    class func nib(_ frame: CGRect) -> Self {
        let view = nib()
        view.frame = frame
        view.layoutIfNeeded()
        return view
    }
}

extension UIView {
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
}

// MARK: - Animations

extension UIView {
    private enum Resource {
        static let duration: Double = 0.3
        static let springDampng: CGFloat = 0.5
        static let springVelocity: CGFloat = 0.5
    }
    
    func scaleAnimation(from: CGFloat, to: CGFloat, _ completion: (() -> Void)? = nil) {
        self.transform = CGAffineTransform(scaleX: from, y: from)
        UIView.animate(withDuration: Resource.duration,
                       delay: 0,
                       usingSpringWithDamping: Resource.springDampng,
                       initialSpringVelocity: Resource.springVelocity,
                       options: .curveEaseInOut,
                       animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: { (_) in
            completion?()
        })
    }
}

extension UIView {
    func addTranslucentLayer(exclude view: UIView, with color: UIColor) {
        let path = UIBezierPath()
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        let excludedMaxX = view.frame.maxX
        let excludedMaxY = view.frame.maxY
        let excludedX = view.frame.origin.x
        let excludedY = view.frame.origin.y
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: maxY))
        path.addLine(to: CGPoint(x: maxX, y: maxY))
        path.addLine(to: CGPoint(x: maxX, y: 0))
        path.addLine(to: .zero)
        path.move(to: CGPoint(x: excludedMaxX, y: excludedY))
        path.addLine(to: CGPoint(x: excludedMaxX, y: excludedMaxY))
        path.addLine(to: CGPoint(x: excludedX, y: excludedMaxY))
        path.addLine(to: CGPoint(x: excludedX, y: excludedY))
        path.addLine(to: CGPoint(x: excludedMaxX, y: excludedY))
        path.close()
        let layer = CAShapeLayer()
        layer.name = "translucentLayer"
        layer.path = path.cgPath
        let layerColor = color.cgColor
        layer.fillColor = layerColor
        layer.strokeColor = layerColor
        self.layer.addSublayer(layer)
    }
    
    func removeTranslucentLayer() {
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                // swiftlint:disable for_where
                if layer.name == "translucentLayer" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}

extension UIView {
    static func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = rectShape
    }
}

extension UIView {
  
    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { [weak self] in self?.alpha = 1 },
                       completion: { (_) in
                        if let complete = onCompletion { complete() }
        }
        )
    }
    
    func fadeOut(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { [weak self] (_) in
                        self?.isHidden = true
                        if let complete = onCompletion { complete() }
            }
        )
    }
}

extension UIView {
    func setEndStyle(color: UIColor = UIColor.white, finishColor: UIColor = UIColor.clear,
                     startPoint: CGPoint = CGPoint(x: 0.70, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.80, y: 0.0)) {
        let gradient = CAGradientLayer()
        
        gradient.frame      = self.bounds
        gradient.colors     = [color.cgColor, finishColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint   = endPoint
        
        self.layer.mask = gradient
    }
    
    func setDampEndStyle() {
        return setEndStyle(color: UIColor.white, startPoint: CGPoint(x: 0.95, y: 0.0), endPoint: CGPoint(x: 0.98, y: 0.0))
    }
}

extension UIView {
    static func whiteView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}

// MARK: - Constraints

extension UIView {
    func constraint(with identifier: String) -> NSLayoutConstraint? {
        return self.constraints.filter { $0.identifier == identifier }.first
    }
    
    func setConstraint(identifier: String, constant: CGFloat) {
        if let constraint = constraint(with: identifier) {
            constraint.constant = constant
        }
    }
    
    func setConstraint(identifier: String, active: Bool) {
        if let constraint = constraint(with: identifier) {
            constraint.isActive = active
        }
    }
}

extension UIView {
    static func coloredView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}

// MARK: - Snapshot

extension UIView {
    func snapShot() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
}

// MARK: - Height/Width adjusting

extension UIView {
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
}
