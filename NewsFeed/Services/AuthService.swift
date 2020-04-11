//
//  AuthService.swift
//  NewsFeed
//
//  Created by MacBook on 02.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import  VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController:UIViewController)
    func authServiceSighIn()
    func authServiceSighInFailed()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
   
    
    private let appId  = "7303367"
    private let vkSDK:VKSdk
    
    weak var delegate:AuthServiceDelegate?
    
    var token:String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId:String? {
        return VKSdk.accessToken()?.userId
    }
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk initialized")
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline,friends,photos,groups,wall"]
        VKSdk.wakeUpSession(scope) {[delegate] (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSighIn()
            default:
                delegate?.authServiceSighInFailed()
                
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSighIn()
        }
        
    }
    
       func vkSdkUserAuthorizationFailed() {
           print(#function)
        delegate?.authServiceSighInFailed()
       }
       
       func vkSdkShouldPresent(_ controller: UIViewController!) {
           print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
       }
       
       func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
           print(#function)
       }
       
}
