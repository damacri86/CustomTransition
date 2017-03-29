//
//  ViewController.swift
//  CustomTransition
//
//  Created by David on 27/3/17.
//  Copyright © 2017 damacri.labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let dismissInteractorController = DismissInteractionController()

    
    @IBAction private func buttonPressed(_ sender: Any) {
        
        let modalViewController = ModalViewController()
        modalViewController.transitioningDelegate = self
        self.dismissInteractorController.wireToViewController(viewController: modalViewController)
        present(modalViewController, animated: true, completion: nil)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        return DismissAnimatorController()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return self.dismissInteractorController.interactionInProgress ? self.dismissInteractorController : nil
    }

}
