//
//  Helper.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import UIKit



extension UITableViewCell {
    static var id: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}
