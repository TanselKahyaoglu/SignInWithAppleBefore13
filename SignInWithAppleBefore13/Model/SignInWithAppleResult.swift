//
//  SignInWithAppleResult.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation

public enum SignInWithAppleResult {
    case Success(code: String), Cancelled, Failed
    
}
