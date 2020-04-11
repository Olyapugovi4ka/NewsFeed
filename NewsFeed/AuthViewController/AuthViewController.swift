//
//  ViewController.swift
//  NewsFeed
//
//  Created by MacBook on 02.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .white
    }

    @IBAction func sighInTouched(_ sender:UIButton){
        authService.wakeUpSession()
    }
}

