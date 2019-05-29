//
//  Animator.swift
//  WebViewSwift
//
//  Created by Gabriele Magi on 13/02/2019.
//  Copyright © 2019 Gabriele Magi. All rights reserved.
//

import Foundation
import UIKit

 class TransitionManager : UIPercentDrivenInteractiveTransition {
    
    var interactive = false
    var presenting = true
 
    var swipeForPresent, swipeForDismiss: UIScreenEdgePanGestureRecognizer!
    
    var presentingVc : UIViewController! {
        didSet {
            swipeForPresent = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeRight(gesture:)))
            swipeForPresent.edges = .right
            presentingVc.view.addGestureRecognizer(swipeForPresent)
        }
    }
    
    var presentedVc : UIViewController! {
        didSet {
            swipeForDismiss = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeLeft(gesture:)))
            swipeForDismiss.edges = .left
            presentedVc.view.addGestureRecognizer(swipeForDismiss)
            presentedVc.transitioningDelegate = self
        }
    }
    
    @objc func handleSwipeRight(gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!.superview)
        
        // do some math to translate this to a percentage based value
        let d =  translation.x / gesture.view!.bounds.width * 1.5
        
        // now lets deal with different states that the gesture recognizer sends
        switch (gesture.state) {
            
        case .began:
            
            interactive = true
            
            presentingVc.present(presentedVc, animated: true)
            break
            
        case .changed:
            
            update(-d)
            
            break
            
        default:
            let velocity = gesture.velocity(in: gesture.view)
            completionSpeed = 0.999
            if (-d > 0.5 && velocity.x == 0) || velocity.x < 0 {
                finish()
            } else {
                cancel()
            }
            interactive = false
        }
    }
    
    
    @objc func handleSwipeLeft(gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!.superview)
        
        // do some math to translate this to a percentage based value
        let d =  translation.x / gesture.view!.bounds.width * 1.5
        
        switch (gesture.state) {
            
        case .began:
            interactive = true
            
            presentedVc.dismiss(animated: true)
            break
            
        case .changed:
            update(d)
            
            break
            
        default:
            let velocity = gesture.velocity(in: gesture.view)
            completionSpeed = 0.999
            if (d > 0.5 && velocity.x == 0) || velocity.x > 0 {
                finish()
            } else {
                cancel()
            }
            interactive = false
        }
        
    }
    
}



extension TransitionManager : UIViewControllerAnimatedTransitioning {
    
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)

        let offScreenRight = CGAffineTransform (translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)

        container.addSubview(toView!)
        
        if (presenting) {
            
            toView!.transform = offScreenRight
        }
        else {
            toView!.transform = offScreenLeft
        }
        
        
        let duration = transitionDuration(using: transitionContext)
        
    
        UIView.animate(withDuration: duration, animations: {
           
            toView!.transform = CGAffineTransform.identity
            if (self.presenting) {
                
                fromView!.transform = offScreenLeft
            }
            else {
                fromView!.transform = offScreenRight
            }
            
        }, completion: { finished in
            
            // tell our transitionContext object that we've finished animating
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

}




extension TransitionManager : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }


}
