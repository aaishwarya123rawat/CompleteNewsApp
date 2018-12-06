//
//  ActivityIndicator.swift
//  loginSignup
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator: UIActivityIndicatorView{

    var spinner = UIActivityIndicatorView()
    
    func showLoader(view: UIView) {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.white;
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        self.spinner = spinner
    }
    
    func dismissLoader() {
        
        self.spinner.stopAnimating()
    
        
    }

}
