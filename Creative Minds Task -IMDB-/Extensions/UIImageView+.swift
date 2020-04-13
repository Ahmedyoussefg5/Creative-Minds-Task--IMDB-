//
//  UIImageView+.swift
//  MVC To MVP
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    func loadImageData(url: String?) {
        image = #imageLiteral(resourceName: "placeHolder")
        guard let urlString = url, let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).response {[weak self] (data) in
            if let data = data.data {
                let image = UIImage(data: data, scale: 1)
                self?.image = image ?? #imageLiteral(resourceName: "placeHolder")
            } else if let _ = data.error {
                self?.image = #imageLiteral(resourceName: "placeHolder")
            }
        }
    }
}
