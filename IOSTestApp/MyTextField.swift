//
//  MyTextField.swift
//  IOSTestApp
//
//  Created by Hoang Vu on 09/07/2022.
//

import Foundation
import UIKit

class MyTextField : UITextField, UITextFieldDelegate{
    
    let padding = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
}
