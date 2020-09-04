//
//  SignInWithAppleConfiguration.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation

public struct SignInWithAppleConfiguration {
    //This class will use for configuration of url
    //Now I can not handle scope because of wkwebview.
    //I will found a solution for scope problem
    
    var clientId: String
    var redirectUri:String
  //  var scope: [SignInWithAppleScope] //ToDo:
    var loggingActive: Bool
    
    /**
     Creates a new configuration for Sign In With Apple Web Auth.
     - Parameter clientId: ServiceId identifier for your application. (from: https://developer.apple.com/account/resources/identifiers/list).
     - Parameter redirectUri: Redirection uri for result of auth. It cames from ServiceId-> Website URLs -> RedirectionURLs.
     - Parameter loggingActive: Console log status for Framework Debug. Default is false.
     */
    public init(clientId: String,
         redirectUri: String,
         loggingActive: Bool = false) {
         //scope: [SignInWithAppleScope]) {
        self.clientId = clientId
        self.redirectUri = redirectUri
      //  self.scope = scope
        self.loggingActive = loggingActive
    }
    
}
