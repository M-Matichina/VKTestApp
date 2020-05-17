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
        authService.wakeUpSession { [weak self] (accessToken) in 
            guard let strongSelf = self else { return }
            
            if accessToken != nil {
                let newsFeedVC = NewsFeedViewController()
                newsFeedVC.modalPresentationStyle = .fullScreen
                strongSelf.navigationController?.pushViewController(newsFeedVC, animated: true)
            } else {
                print(Error.self)
            }
        }
    }
}

