//
//  ViewController.swift
//  AnimationDemo
//
//  Created by serfusE on 23/03/2018.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var orangeBlock: UIView!
    @IBOutlet weak var pinkBlock: UIView!
    @IBOutlet weak var purpleBlock: UIView!
    @IBOutlet weak var greenBlock: UIView!
    @IBOutlet weak var blueBlock: UIView!
    @IBOutlet weak var greyBlock: UIView!
    @IBOutlet weak var magentaBlock: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*** Constants */
        
        let oldWidth: CGFloat = 100
        let newWidth: CGFloat = 60
        let a_Interval: TimeInterval = 0.8
        let b_Interval: TimeInterval = 2
        
        let positionAnimation = CABasicAnimation(keyPath: "position")
        let radiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        
        
        /*** Orange */
        
        UIView.animate(withDuration: a_Interval) {
            self.orangeBlock.frame = CGRect(x: 38, y: 70, width: 300, height: 60)
        }
        
        /*** Pink */
        
        UIView.animate(withDuration: b_Interval) {
            self.pinkBlock.frame = CGRect(x: 38, y: 140, width: newWidth, height: newWidth)
            self.pinkBlock.layer.cornerRadius = newWidth / 2
        }
        
        /*** Purple */
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(b_Interval)
        
        // timeingFuction
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        // alter:
        /* let timingFunction = CAMediaTimingFunction(controlPoints: 0.65, -0.55, 0.27, 1.55)
         CATransaction.setAnimationTimingFunction(timingFunction) */
        
        UIView.animate(withDuration: b_Interval) {
            self.purpleBlock.frame = CGRect(x: 38, y: 338, width: newWidth, height: newWidth)
        }
        
        radiusAnimation.fromValue = oldWidth / 2
        radiusAnimation.toValue = newWidth / 2 // alter: radiusAnimation.byValue = -20
        // CATransaction 设置过，可不用重复设置
        // radiusAnimation.duration = longInterval
        
        purpleBlock.layer.add(radiusAnimation, forKey: "cornerRadius")
        // 动画并不会更改对象的图层属性，当动画展示完成后，需要属性值的更新
        purpleBlock.layer.cornerRadius = newWidth / 2
        
        CATransaction.commit()
        
        /*** Green */
        
        var greenBlockLayer: CALayer {
            return greenBlock.layer
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(b_Interval)
        
        positionAnimation.fromValue = [38, 484]
        positionAnimation.toValue = [112, 484]
        greenBlockLayer.add(positionAnimation, forKey: "position")
        greenBlockLayer.position = CGPoint(x: 112, y: 484)
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(b_Interval)

        UIView.animate(withDuration: b_Interval) {
            self.greenBlock.alpha = 0.5
        }

        CATransaction.commit()
        CATransaction.commit()
        
        /*** Blue */
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, 10, -10, 10, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true

        blueBlock.layer.add(shakeAnimation, forKey: "position.x")
        
        /*** Grey */
        
        let boundingRect = CGRect(x: -150, y: -150, width: 300, height: 300)
        let orbitAnimation = CAKeyframeAnimation(keyPath: "position")
        orbitAnimation.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbitAnimation.duration = 4
        orbitAnimation.isAdditive = true
        orbitAnimation.repeatCount = Float.infinity
        orbitAnimation.calculationMode = kCAAnimationPaced
        orbitAnimation.rotationMode = kCAAnimationRotateAuto
        
        greyBlock.layer.add(orbitAnimation, forKey: "position")
        
        /*** Magenta */
        
        let aniGroup = CAAnimationGroup()
        aniGroup.animations = [shakeAnimation, radiusAnimation]
        aniGroup.duration = 3
        
        magentaBlock.layer.add(aniGroup, forKey: "whatsoever")
        magentaBlock.layer.cornerRadius = 30
        
        
    }

}

