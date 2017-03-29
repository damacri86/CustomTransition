//
//  DismissAnimatorController.swift
//  CustomTransition
//
//  Created by David on 27/3/17.
//  Copyright © 2017 damacri.labs. All rights reserved.
//

import UIKit

class DismissAnimatorController: NSObject {
    
}

extension DismissAnimatorController: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 2.0
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard
            let fromViewController = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.to)
            else { return }
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        
                        fromViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height), size: UIScreen.main.bounds.size)
        },
                       completion: { _ in
                        
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
