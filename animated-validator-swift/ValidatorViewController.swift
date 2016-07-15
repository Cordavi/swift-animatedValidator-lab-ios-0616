//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet weak var emailTextField: UITextField!
   @IBOutlet weak var emailConfirmationTextField: UITextField!
   @IBOutlet weak var phoneTextField: UITextField!
   @IBOutlet weak var submitButton: UIButton!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var passwordConfirmTextField: UITextField!
   
   var emailIsValid = false
   var emailConfirmIsValid = false
   var phoneNumberIsValid = false
   var passwordIsValid = false
   var passwordConfirmIsValid = false
   var submitButtonLocation: NSLayoutConstraint?
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view, typically from a nib.
      self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
      self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
      self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
      self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
      self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
      self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
      
      //remove all IB constraints
      view.removeConstraints(view.constraints)
      view.translatesAutoresizingMaskIntoConstraints = false
      submitButton.translatesAutoresizingMaskIntoConstraints = false
      emailTextField.translatesAutoresizingMaskIntoConstraints = false
      emailConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
      phoneTextField.translatesAutoresizingMaskIntoConstraints = false
      passwordTextField.translatesAutoresizingMaskIntoConstraints = false
      passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
      
      //////////set constraints//////////////
      
      //email field constraints
      emailTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      emailTextField.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 56).active = true
      emailTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -(view.frame.width * 0.25)).active = true
      
      //email confirm  field constraints
      emailConfirmationTextField.centerXAnchor.constraintEqualToAnchor(emailTextField.centerXAnchor).active = true
      emailConfirmationTextField.topAnchor.constraintEqualToAnchor(emailTextField.topAnchor, constant: 46).active = true
      emailConfirmationTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -(view.frame.width * 0.25)).active = true
      
      //phone field constraints
      phoneTextField.centerXAnchor.constraintEqualToAnchor(emailConfirmationTextField.centerXAnchor).active = true
      phoneTextField.topAnchor.constraintEqualToAnchor(emailConfirmationTextField.topAnchor, constant: 46).active = true
      phoneTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -(view.frame.width * 0.25)).active = true
      
      //password field constraints
      passwordTextField.centerXAnchor.constraintEqualToAnchor(phoneTextField.centerXAnchor).active = true
      passwordTextField.topAnchor.constraintEqualToAnchor(phoneTextField.topAnchor, constant: 46).active = true
      passwordTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -(view.frame.width * 0.25)).active = true
      
      //password confirm field constraints
      passwordConfirmTextField.centerXAnchor.constraintEqualToAnchor(passwordTextField.centerXAnchor).active = true
      passwordConfirmTextField.topAnchor.constraintEqualToAnchor(passwordTextField.topAnchor, constant: 46).active = true
      passwordConfirmTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -(view.frame.width * 0.25)).active = true
      
      //submit button constraints
      submitButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      submitButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.5).active = true
      submitButtonLocation = submitButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -56)
      submitButtonLocation?.active = true
      
      //assign delegates
      emailTextField.delegate = self
      emailConfirmationTextField.delegate = self
      phoneTextField.delegate = self
      passwordTextField.delegate = self
      passwordConfirmTextField.delegate = self
      
      self.submitButton.enabled = false
   }
   
   func animateSubmitButton() {
      UIView.animateWithDuration(0.5) {
         self.submitButtonLocation?.active = false
         self.submitButton.topAnchor.constraintEqualToAnchor(self.passwordConfirmTextField.bottomAnchor, constant: 26).active = true
         self.submitButton.enabled = true
         self.view.layoutIfNeeded()
      }
   }
   
   func allFeildValid() {
      if emailIsValid && emailConfirmIsValid && phoneNumberIsValid && passwordIsValid && passwordConfirmIsValid {
         animateSubmitButton()
      }
   }
   
   func textFieldDidEndEditing(textField: UITextField) {
      isValidText(textField)
      allFeildValid()
   }
   
   func stringIsOnlyNumbers(phoneNumber: String) -> Bool {
      let notNumbers = NSCharacterSet.decimalDigitCharacterSet().invertedSet
      if phoneNumber.rangeOfCharacterFromSet(notNumbers) == nil {
         return true
      }
      return false
   }
   
   func animateField(textField: UITextField) {
      UIView.animateWithDuration(0.4, delay: 0, options: [], animations: {
         textField.transform = CGAffineTransformMakeScale(1.02, 1.02)
         textField.backgroundColor = UIColor(red: 256, green: 0, blue: 0, alpha: 0.3)
         self.view.layoutIfNeeded()
         }, completion: {_ in
            UIView.animateWithDuration(0.4, animations: {
               textField.transform = CGAffineTransformMakeScale(1.0, 1.0)
               textField.backgroundColor = UIColor.clearColor()
               self.view.layoutIfNeeded()
            })
      })
   }
   
   func isValidText(textField: UITextField) {
      guard let textEntered = textField.text where !textEntered.isEmpty else {
         return
      }
      
      switch textField {
      case emailTextField:
         if textEntered.containsString("@") && textEntered.containsString(".") {
            emailIsValid = true
         } else {
            animateField(textField)
         }
      case emailConfirmationTextField:
         if textEntered == emailTextField.text {
            emailConfirmIsValid = true
         } else {
            animateField(textField)
         }
      case phoneTextField:
         if textEntered.characters.count >= 7 && stringIsOnlyNumbers(textEntered) {
            phoneNumberIsValid = true
         } else {
            animateField(textField)
         }
      case passwordTextField:
         if textEntered.characters.count >= 6 {
            passwordIsValid = true
         } else {
            animateField(textField)
         }
      case passwordConfirmTextField:
         if textEntered == passwordTextField.text {
            passwordConfirmIsValid = true
         } else {
            animateField(textField)
         }
      default:
         break
      }
   }
}
