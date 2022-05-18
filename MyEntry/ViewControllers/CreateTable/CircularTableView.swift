//
//  CircularTableView.swift
//  MyEntry
//
//  Created by Kinjal panchal on 20/02/22.
//

import Foundation
import UIKit

@IBDesignable
class CircularTableView: UIView {
    
    @IBInspectable var seats: CGFloat = 2
    @IBInspectable var circleSize: CGFloat = 150 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    private var circleHeightCons: NSLayoutConstraint!
    private var circleWidthCons: NSLayoutConstraint!
    
    var sheatHeight: CGFloat {
        return circleSize / 4.16
    }
    var sheatWidth: CGFloat {
        sheatHeight * 1.11
    }
    
    var sheatHiddenHeight: CGFloat {
        sheatHeight / 6.14
    }
    
    private let seatImage = UIImage(named: "tbl_seat_1")!
    
    let circleImageView = UIImageView(image:  UIImage(named: "tbl_circle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var intrinsicContentSize: CGSize {
        let size = self.circleSize + (sheatHeight * 2)
        return CGSize(width: size, height: size)
    }
    
    private func setupView() {
        createObjectsAroundCircle()
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func createObjectsAroundCircle() {
        let center = CGPoint(x: bounds.size.width/2, y: bounds.size.width/2)
        let radius: CGFloat = (bounds.size.width/2) - self.sheatHeight
        let count = Int(seats)

        let pi = Double.pi
        var angle = CGFloat(2 * pi)
        let step = CGFloat(2 *  pi) / CGFloat(count)

        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(pi * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(hexString: "#A1C3FC").cgColor //UIColor(named: "LightBlue")!.cgColor
        shapeLayer.lineWidth = 2.0

        layer.addSublayer(shapeLayer)
        // Set objects around the circle
        for index in 0..<count {
            let imageView = UIImageView(image: seatImage)
            imageView.sizeToFit()
            
            // Position
            let x = cos(angle) * radius + center.x
            let y = sin(angle) * radius + center.y
            let midX = imageView.frame.origin.x + imageView.frame.width / 2
            let mixY = imageView.frame.origin.y + imageView.frame.height / 2
            
            imageView.frame.origin.x = x - midX
            imageView.frame.origin.y = y - mixY
            let degree = index == 0 ? 0 : Double(count / index) * 360
            imageView.transform = .init(rotationAngle: CGFloat(degree))
            
            addSubview(imageView)
            angle += step
        }
    }
    
}
