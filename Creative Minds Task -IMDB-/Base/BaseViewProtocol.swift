//
//  BaseViewProtocol.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

protocol BaseViewProtocol where Self: UIViewController {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlert(with message: String)
}

extension BaseViewProtocol {
    
    func showActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.color = #colorLiteral(red: 0.3346029818, green: 0.3666692972, blue: 0.9529878497, alpha: 1)
        // Useing Tag Is Bad // To Fix
        activityIndicatorView.tag = 98777
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }
    
    func hideActivityIndicator() {
        view.viewWithTag(98777)?.removeFromSuperview()
    }
    
    func showAlert(with message: String) {
        showAlert(message: message)
    }
}
