//
//  FirstViewController.swift
//  WebViewSwift
//
//  Created by Gabriele Magi on 12/02/2019.
//  Copyright © 2019 Gabriele Magi. All rights reserved.
//

import Foundation
import UIKit

class FirstViewController : UIViewController, UIViewControllerTransitioningDelegate {
    
    var secondViewController : SecondViewController!
    var thirdViewController : ThirdViewController!
    var transitionManager, transitionManager2 : TransitionManager!

    override func viewDidLoad() {
     
        super.viewDidLoad()
    
    
        secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as? SecondViewController
        thirdViewController = self.storyboard?.instantiateViewController(withIdentifier: "thirdViewController") as? ThirdViewController
        
        
        transitionManager = TransitionManager()
        
        transitionManager.presentingVc = self
        transitionManager.presentedVc = secondViewController
        
        
        transitionManager2 = TransitionManager()
        
        transitionManager2.presentingVc = secondViewController
        transitionManager2.presentedVc = thirdViewController
        
        
    }
    
        
}

