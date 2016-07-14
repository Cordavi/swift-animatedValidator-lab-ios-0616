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
      
      //set constraints
      
      //email field constraints
      emailTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      emailTextField.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 56).active = true
      emailTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.75).active = true

      //email confirm  field constraints
      emailConfirmationTextField.centerXAnchor.constraintEqualToAnchor(emailTextField.centerXAnchor).active = true
      emailConfirmationTextField.topAnchor.constraintEqualToAnchor(emailTextField.topAnchor, constant: 46).active = true
      emailConfirmationTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.75).active = true
      
      //phone field constraints
      phoneTextField.centerXAnchor.constraintEqualToAnchor(emailConfirmationTextField.centerXAnchor).active = true
      phoneTextField.topAnchor.constraintEqualToAnchor(emailConfirmationTextField.topAnchor, constant: 46).active = true
      phoneTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.75).active = true
      
      //password field constraints
      passwordTextField.centerXAnchor.constraintEqualToAnchor(phoneTextField.centerXAnchor).active = true
      passwordTextField.topAnchor.constraintEqualToAnchor(phoneTextField.topAnchor, constant: 46).active = true
      passwordTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.75).active = true
      
      //password confirm field constraints
      passwordConfirmTextField.centerXAnchor.constraintEqualToAnchor(passwordTextField.centerXAnchor).active = true
      passwordConfirmTextField.topAnchor.constraintEqualToAnchor(passwordTextField.topAnchor, constant: 46).active = true
      passwordConfirmTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.75).active = true
      
      //submit button constraints
      submitButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      submitButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.5).active = true
      submitButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -56).active = true
      
      
      emailTextField.delegate = self
      emailConfirmationTextField.delegate = self
      phoneTextField.delegate = self
      passwordTextField.delegate = self
      passwordConfirmTextField.delegate = self
      
      self.submitButton.enabled = false
   }
   
   func checkTextField() {
      
   }
   
   func textFieldDidEndEditing(textField: UITextField) {
      
      if !isValidText(textField) {
         //invalid annimation
      }
      //check if all fields are true
   }
   
   func stringIsOnlyNumbers(phoneNumber: String) -> Bool {
      let notNumbers = NSCharacterSet.decimalDigitCharacterSet().invertedSet
      if phoneNumber.rangeOfCharacterFromSet(notNumbers) == nil {
         return true
      }
      return false
   }
   
   func isValidText(textField: UITextField) -> Bool {
      guard let textEntered = textField.text else { return false }
      
      switch textField {
      case emailTextField:
         if textEntered.containsString("@") && textEntered.containsString(".") {
            emailIsValid = true
            return true
         }
         return false
      case emailConfirmationTextField:
         if textEntered == emailTextField.text {
            emailConfirmIsValid = true
            return true
         }
         return false
      case phoneTextField:
         if textEntered.characters.count >= 7 && stringIsOnlyNumbers(textEntered) {
            phoneNumberIsValid = true
            return true
         }
         return false
      case passwordTextField:
         if textEntered.characters.count >= 6 {
            passwordIsValid = true
            return true
         }
         return false
      case passwordConfirmTextField:
         if textEntered == passwordTextField.text {
            passwordConfirmIsValid = true
            return true
         }
         return false
      default:
         return false
      }
   }
}
