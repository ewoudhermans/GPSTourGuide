//
//  SignInViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signInTouched(sender: AnyObject) {
        let signin = SignIn(user: userName.text!, pass: userPassword.text!)
        
        do {
            // call signIn model function SignInUser()
            // anything under this try will execute if signInUser returns true
            try signin.signInUser()
            
            // dismiss view controller and go to MainViewController
            self.dismissViewControllerAnimated(true, completion: nil)
            
            // catches error thrown by SignInUser() if there is one
        } catch let error as Error {
            print(error.description)
        } catch {
            print("Sorry something went\n wrong please try again")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
