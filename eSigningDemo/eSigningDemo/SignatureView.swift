//
//  SignatureView.swift
//  eSigningDemo
//
//  Created by Margels on 11/09/24.
//

import Foundation
import UIKit

class SignatureView: UIView {
    
    private var path = UIBezierPath()
    private var touchPoint: CGPoint = .zero
    
    // Set the stroke color and width for the signature
    private let strokeColor = UIColor.black.cgColor
    private let lineWidth: CGFloat = 2.0
    
    var onBeginDrawing: (()->Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPoint = touch.location(in: self)
            self.onBeginDrawing?()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            path.move(to: touchPoint)
            path.addLine(to: currentPoint)
            touchPoint = currentPoint
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(strokeColor)
        context.setLineWidth(lineWidth)
        context.setLineCap(.round)
        context.addPath(path.cgPath)
        context.strokePath()
    }
    
    func clear() {
        path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    func getSignatureImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        defer { UIGraphicsEndImageContext() }
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
