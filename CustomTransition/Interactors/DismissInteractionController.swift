//
//  DismissInteractionController.swift
//  CustomTransition
//
//  Created by David on 27/3/17.
//  Copyright © 2017 damacri.labs. All rights reserved.
//

import UIKit

class DismissInteractionController: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!

    
    func wireToViewController(viewController: UIViewController!) {
        
        self.viewController = viewController
        preparePanRecognizer(view: viewController.view)
    }
    
    private func preparePanRecognizer(view: UIView) {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        
        let percentThreshold:CGFloat = 0.3        
        let translation = sender.translation(in: viewController.view)
        let verticalMovement = translation.y / viewController.view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        switch sender.state {
        case .began:
            self.interactionInProgress = true
            self.viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            self.shouldCompleteTransition = progress > percentThreshold
            self.update(progress)
            
        case .cancelled:
            self.interactionInProgress = false
            self.cancel()
            
        case .ended:
            self.interactionInProgress = false
            self.shouldCompleteTransition ? self.finish() : self.cancel()
            
        default:
            NSLog("Unsupported")
            
        }
        
    }
}
