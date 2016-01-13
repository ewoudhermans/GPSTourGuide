//
//  SignUpViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorSignUpLabel: UILabel!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        userName.delegate = self
        userEmail.delegate = self
        userPassword.delegate = self
        confirmPassword.delegate = self
    }

    @IBAction func signUpTouched(sender: AnyObject) {
        
        errorSignUpLabel.text = ""
        
        let signup = SignUp(fName: firstName.text!, lName: lastName.text!, uName: userName.text!, uEmail: userEmail.text!, uPassword: userPassword.text!, cPassword: confirmPassword.text!)
        
        do {
            try signup.signUpUser()
            let alert = succesfullSignUp()
            presentViewController(alert, animated: true, completion: nil)
        } catch let error as Error{
            errorSignUpLabel.text = error.description
        } catch {
            errorSignUpLabel.text = "Sorry, something went wrong, please try again"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func succesfullSignUp() -> UIAlertController {
        let alertView = UIAlertController(title: "Sign up succesfull", message: "Your sign up was a success!", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "login", style: .Default, handler: { (alertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        return alertView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
