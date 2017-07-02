//
//  UIViewController+Utils
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var activityIndicatorTag: Int { return 999999 }
    
    func showLoading() {
        
         DispatchQueue.main.async(execute: {
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.center = CGPoint(x: self.view.frame.size.width / 2, y: (self.view.frame.size.height / 2) )
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
            
            UIApplication.shared.beginIgnoringInteractionEvents()
        })
    }
    
    func hideLoading() {
        
        DispatchQueue.main.async(execute: {
           
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                
                 UIApplication.shared.endIgnoringInteractionEvents()
            }
        })
    }
}
