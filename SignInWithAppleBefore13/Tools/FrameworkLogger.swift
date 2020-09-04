//
//  FrameworkLogger.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation

internal class FrameworkLogger {
    
    var isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
    }
    
    func log(_ message: String) {
        if isActive {
            print("[SignInWithApple] \(message)")
        }
    }
    
}
