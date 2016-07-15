//
//  SplashViewController.swift
//  MoodAlarmS
//
//  Created by Angelica Bato on 7/14/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

import UIKit
import QuartzCore

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = UIButton()
        logInButton.setTitle("Login With Spotify", forState: .Normal)
        logInButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        logInButton.layer.cornerRadius = 15
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.blackColor().CGColor
        
        let continueWOLogin = UIButton()
        continueWOLogin.setTitle("Start Using Without Spotify", forState: .Normal)
        continueWOLogin.setTitleColor(UIColor.blackColor(), forState: .Normal)
        continueWOLogin.layer.cornerRadius = 15
        continueWOLogin.layer.borderWidth = 1
        continueWOLogin.layer.borderColor = UIColor.blackColor().CGColor
        
        let stack = UIStackView.init(arrangedSubviews: [logInButton,continueWOLogin])
        stack.axis = .Vertical
        
        self.view.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor .constraintEqualToAnchor(view.centerXAnchor).active = true
        stack.centerYAnchor .constraintEqualToAnchor(view.centerYAnchor).active = true
        stack.widthAnchor .constraintEqualToAnchor(view.widthAnchor, multiplier: 0.7).active = true
        stack.heightAnchor .constraintEqualToAnchor(view.heightAnchor, multiplier: 0.3).active = true
        
        stack.distribution = .FillEqually
        stack.spacing = 5.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
