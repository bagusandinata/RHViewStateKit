//
//  EActivityIndicatorShape.swift
//  app
//
//  Created by Bagus andinata on 18/02/21.
//  Copyright © 2021 wit. All rights reserved.
//

// Copy and Edit partially from https://github.com/ninjaprox/NVActivityIndicatorView 

import UIKit

enum EActivityIndicatorShape {
    case circle
    case ringTwoHalfVertical
    case ringTwoHalfHorizontal

    func layerWith(size: CGSize, color: UIColor) -> CALayer {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 2

        switch self {
        case .circle:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi),
                        clockwise: false)
            layer.fillColor = color.cgColor
        case .ringTwoHalfVertical:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: CGFloat(-3 * Double.pi / 4),
                        endAngle: CGFloat(-Double.pi / 4),
                        clockwise: true)
            path.move(
                to: CGPoint(x: size.width / 2 - size.width / 2 * cos(CGFloat(Double.pi / 4)),
                            y: size.height / 2 + size.height / 2 * sin(CGFloat(Double.pi / 4)))
            )
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: CGFloat(-5 * Double.pi / 4),
                        endAngle: CGFloat(-7 * Double.pi / 4),
                        clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .ringTwoHalfHorizontal:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: CGFloat(3 * Double.pi / 4),
                        endAngle: CGFloat(5 * Double.pi / 4),
                        clockwise: true)
            path.move(
                to: CGPoint(x: size.width / 2 + size.width / 2 * cos(CGFloat(Double.pi / 4)),
                            y: size.height / 2 - size.height / 2 * sin(CGFloat(Double.pi / 4)))
            )
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: CGFloat(-Double.pi / 4),
                        endAngle: CGFloat(Double.pi / 4),
                        clockwise: true)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        }

        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        return layer
    }
}
