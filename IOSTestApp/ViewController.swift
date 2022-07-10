//
//  ViewController.swift
//  IOSTestApp
//
//  Created by Hoang Vu on 09/07/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbTitle: UITextView!
    @IBOutlet weak var lbSubTitle: UITextView!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobileNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var lbTermnadPolicy: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
        attributedLabel();
        attributedTextField();
        
        btnNext.layer.cornerRadius = 20
        
    }

    func attributedLabel(){
        lbTitle.attributedText.accessibilityPath?.lineWidth = 0
        lbSubTitle.attributedText.accessibilityPath?.lineWidth = 0
        
        let urlTerm = URL(string: "https://www.google.com")!
        let urlPolicy = URL(string: "https://www.youtube.com")!
        let termAndPolicyString = "By creating an account, you already agreed with our Term & Conditions and Privacy Policy"
        
        let termAndPolicyText =  NSMutableAttributedString.init(string: termAndPolicyString, attributes: [.font: UIFont.systemFont(ofSize: 16)])
        
        let termRange = NSString(string: termAndPolicyString).range(of: "Term & Conditions", options: String.CompareOptions.caseInsensitive)
        let policyRange = NSString(string: termAndPolicyString).range(of: "Privacy Policy", options: String.CompareOptions.caseInsensitive)
        
        termAndPolicyText.setAttributes([ .link: urlTerm], range: termRange)
        termAndPolicyText.setAttributes([.link: urlPolicy], range: policyRange)
        
        termAndPolicyText.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 16), range: termRange)
        termAndPolicyText.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 16), range: policyRange)
        
        lbTermnadPolicy.linkTextAttributes = [.foregroundColor: UIColor.systemYellow]
        
        lbTermnadPolicy.attributedText = termAndPolicyText
        lbTermnadPolicy.textAlignment = NSTextAlignment.center
        lbTermnadPolicy.isUserInteractionEnabled = true
        
    }
    
    func attributedTextField(){
        tfFullName.attributedPlaceholder = NSAttributedString(string: "Fullname", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        tfEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        tfMobileNumber.attributedPlaceholder = NSAttributedString(string: "Mobile number", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        tfConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        
        tfMobileNumber.keyboardType = .numberPad
        
        tfPassword.isSecureTextEntry = true
        tfConfirmPassword.isSecureTextEntry = true
        
    }

    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {return}
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > (keyboardTopY + 20){
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY * 2/3) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIResponder{
    struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap(){
        Static.responder = self
    }
}
    


