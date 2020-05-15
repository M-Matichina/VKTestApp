//
//  ViewController.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/15/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authService = AuthService()
        authService.wakeUpSession()
    }
}

