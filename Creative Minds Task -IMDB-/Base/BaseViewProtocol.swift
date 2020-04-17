//
//  BaseViewProtocol.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol BaseViewProtocol: NVActivityIndicatorViewable where Self: UIViewController {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlert(with message: String)
}

extension BaseViewProtocol {
    
    func showActivityIndicator() {        
        let size = CGSize(width: 50, height: 50)
        NVActivityIndicatorView.DEFAULT_COLOR = #colorLiteral(red: 0.3346029818, green: 0.3666692972, blue: 0.9529878497, alpha: 1)
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = .clear
        startAnimating(size, message: "", type: .ballClipRotate)
    }
    
    func hideActivityIndicator() {
        stopAnimating()
    }
    
    func showAlert(with message: String) {
        showAlert(message: message)
    }
}
