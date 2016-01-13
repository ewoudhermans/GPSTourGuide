//
//  SignUp.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation
import Parse
import Bolts

class SignUp: NSObject {
    
    var firstName: String?
    var lastName: String?
    var userName: String?
    var userEmail: String?
    var userPassword: String?
    var confirmPassword: String?

    init(fName: String, lName: String, uName: String, uEmail: String, uPassword: String, cPassword: String) {
        
        self.firstName = fName
        self.lastName = lName
        self.userName = uName
        self.userEmail = uEmail
        self.userPassword = uPassword
        self.confirmPassword = cPassword
    }
    
    func signUpUser()throws -> Bool {
        guard hasEmptyFields() else {
            throw Error.EmptyField
        }
        guard isValidEmail() else {
            throw Error.InvalidEmail
        }
        guard validatePasswordMatch() else {
            throw Error.PasswordsDoNotMatch
        }
        guard storeNewUser() else {
            throw Error.UserNameTaken
        }
        return true
    }
    
    func hasEmptyFields() -> Bool {
        if !firstName!.isEmpty && !lastName!.isEmpty && !userName!.isEmpty && !userEmail!.isEmpty && !userPassword!.isEmpty && !confirmPassword!.isEmpty {
            return true
        }
        return false
    }
    
    func isValidEmail() -> Bool {
        let email = "[A-Z0-9a-z.+_-%]+@[A-Z0-9a-z.+_-%]+\\.[A-Za-z]"
        let range = userEmail!.rangeOfString(email, options: .RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func validatePasswordMatch() -> Bool {
        if(userPassword! == confirmPassword!) {
            return true
        }
        return false
    }
    
    func storeNewUser() -> Bool {
        
        var success = false
        let user = PFUser()
        
        user["Firstname"] = firstName!
        user["Lastname"] = lastName!
        user.username = userName!
        user.email = userEmail!
        user.password = userPassword!
        
        user.signUpInBackground()
        success = user.isNew
        return success
    }
    
    
    
    
}
