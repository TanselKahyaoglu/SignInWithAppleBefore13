//
//  WkWebView+SignInWithAppleConfiguration.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func load(_ configuration: SignInWithAppleConfiguration) {
        let baseAuthUrl = "https://appleid.apple.com/auth/authorize"
        let params: [String: String] = ["client_id": configuration.clientId,
                                        "redirect_uri": configuration.redirectUri,
                                        "response_type": "code",
                                        //  "scope": configuration.scope.map { $0.rawValue }.joined(separator: "+"),
            //  "response_mode": "form_post"
            "response_mode": "fragment"] //ToDo: change to form_post
        guard var components = URLComponents(string: baseAuthUrl) else { return }
        components.queryItems = params.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%20")
        guard let url = components.url else { return }
        load(URLRequest(url: url))
    }
    
}
