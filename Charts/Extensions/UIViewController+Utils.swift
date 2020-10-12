//
//  UIViewController+Utils.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import UIKit

extension UIViewController {
    
    class func initWithNib<T : UIViewController>() -> T {
        return self.init(nibName: String(describing: self.classForCoder()), bundle: nil) as! T
    }
}
