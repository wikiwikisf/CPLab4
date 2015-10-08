//
//  ViewController.swift
//  CPLab4
//
//  Created by Christopher McMahon on 10/7/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGFloat!
    
    var newlyCreatedFace: UIImageView!
    var faceOriginalCenter: CGPoint!

    
    @IBAction func onTapGesture(sender: AnyObject) {
        
    }
    
    @IBAction func onPanImage(panGestureRecognizer: UIPanGestureRecognizer) {
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            faceOriginalCenter = newlyCreatedFace.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = panGestureRecognizer.translationInView(trayView)
            newlyCreatedFace.center =  CGPoint(x: faceOriginalCenter.x,
                y: faceOriginalCenter.y + translation.y)

            
        }
    }

    @IBAction func onPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = panGestureRecognizer.locationInView(trayView.superview)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            self.trayOriginalCenter = trayView.center
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = panGestureRecognizer.translationInView(trayView)
            trayView.center = CGPoint(x: trayOriginalCenter.x,
                y: trayOriginalCenter.y + translation.y)

            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            let velocity = panGestureRecognizer.velocityInView(trayView)
            if velocity.y > 0 {
                print("moving down")
                // move down - then go to the tray center when open
                UIView.animateWithDuration(NSTimeInterval(0.5), delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.trayView.center = CGPoint(x: self.trayView.center.x, y: self.trayCenterWhenClosed)
                    }, completion: nil)

            } else {
                print("moving up")
                // moving up!
                /*UIView.animateWithDuration(NSTimeInterval(0.5), animations: { () -> Void in
                    //self.trayView.center = CGPoint(x: self.trayView.center.x, y: self.trayCenterWhenOpen)
                    self.trayView.center = self.trayCenterWhenOpen
                    }, completion: nil)
*/
                UIView.animateWithDuration(NSTimeInterval(0.5), delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenOpen
                    }, completion: nil)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trayCenterWhenOpen = trayView.center
       // trayCenterWhenOpen = CGRectGetMaxY(trayView.frame)
        print("when open \(trayCenterWhenOpen)")
        trayCenterWhenClosed = CGRectGetMaxY(trayView.frame) + 85.0
        print("when closed \(trayCenterWhenClosed)")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

