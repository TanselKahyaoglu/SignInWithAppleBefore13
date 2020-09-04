//
//  SignInWithAppleWebAuthView.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SignInWithAppleWebAuthView: UIView {
    
    //Completion closure for result
    private var onCompletion: ((SignInWithAppleResult) -> Void)?
    
    //Configuration struct (initially empty values)
    private var configuration = SignInWithAppleConfiguration(clientId: "", redirectUri: "")
    
    //Views
    private var wkWebView: WKWebView?
    private var toolbar: UIView?
    
    private var isShowedWithAnimation = true
    private var isShowing = false
    
    //Logger
    private var logger = FrameworkLogger(isActive: false)
    
    
    init(configuration: SignInWithAppleConfiguration) {
        super.init(frame: .zero)
        self.configuration = configuration
        logger.isActive = configuration.loggingActive
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /**
     Show auth webview on application root window.
     - Parameter animation: Animate view on adding to rootview. Default is true.
     - Parameter onCompletion: Result of auth request on auth server.
     */
    internal func show(with animation: Bool = true,
                       onCompletion: @escaping ((SignInWithAppleResult)->Void)) {
        if configuration.clientId.isEmpty {
            logger.log("Client Id can not be empty")
            return
        } else if configuration.redirectUri.isEmpty {
            logger.log("Redirect Uri can not be empty")
            return
        }
        /* else if configuration.scope.isEmpty {
         printError("Scope can not be empty")
         return
         }
         */
        self.onCompletion = onCompletion
        isShowedWithAnimation = animation //set animation status
        isShowing = true //Set visibility status
        configureViews()
        wkWebView?.load(configuration)
        if animation { //if user wants animation
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1.0
            })
        } else { //show without animation
            alpha = 1.0
        }
    }
    
    private func hide() {
        if isShowing {
            isShowing = false
            if isShowedWithAnimation {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 0.0
                }, completion: { _ in
                    self.removeFromSuperview()
                })
            } else {
                self.removeFromSuperview()
            }
        }
    }
    
    //Configure views on code
    private func configureViews() {
        configureMainView()
        configureTopBar()
        configureWebview()
    }
    
    //Init base view and give constraints
    private func configureMainView() {
        alpha = 0.0
        addSubViewToMainWindow()
        pinEdgesToSuperView(edges: [.top, .bottom, .leading, .trailing]) //pin all edges to superview
    }
    
    //Init top bar with close button and give constaints
    private func configureTopBar() {
        toolbar = UIView()
        toolbar?.setHeight(height: 70) //give static height
        guard let toolbar = toolbar else { return }
        addSubview(toolbar)
        toolbar.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00) //give background color to apple pages top color
        toolbar.pinEdgesToSuperView(edges: [.leading, .top, .trailing]) //pin top, left, right to superview
        addCloseButton()
    }
    
    //add close button to topbar and give constraints
    private func addCloseButton() {
        guard let toolbar = toolbar else { return }
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named:"ic_close", in:  Bundle(for: type(of: self)), compatibleWith:nil), for: .normal)
        toolbar.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(actionClose), for: .touchUpInside) //set action
        closeButton.pinEdgeToView(edge: .top, toView: toolbar, toEdge: .top, constant: 30) //pin top to toolbar top with margin
        closeButton.pinEdgeToView(edge: .trailing, toView: toolbar, toEdge: .trailing, constant: -20) //pin right to superview right with margin
    }
    
    //Configure webview and give constraints
    private func configureWebview() {
        wkWebView = WKWebView(frame: self.frame)
        guard let wkWebView = wkWebView, let toolbar = toolbar else { return }
        addSubview(wkWebView)
        wkWebView.pinEdgeToView(edge: .top, toView: toolbar, toEdge: .bottom) //pin top to toolbar bottom
        wkWebView.pinEdgesToSuperView(edges: [.leading, .bottom, .trailing]) //pin left, right and bottom to superview
        wkWebView.uiDelegate = self //for listening new tab open (forgot password etc.)
        wkWebView.navigationDelegate = self //for listening link change and getting code
    }
    
    //Get root window and add self to it
    private func addSubViewToMainWindow() {
        WindowManager.getWindow()?.addSubview(self)
    }
    
    //Close button action.
    //It gives false result onCompletion
    @objc
    private func actionClose(_ sender: Any) {
        onCompletion?(.Cancelled)
        hide()
    }
    
    //Split codes from query.
    private func getCodeFromUrl(url: String) -> String {
        let parts = url.split(separator: "#")
        guard let code = parts.last?.split(separator: "=").last else { return "" }
        return String(code)
    }
    
    private func handleRedirectUri(url: String) {
        let result = (getCodeFromUrl(url: url))
        if result.isEmpty {
            onCompletion?(.Failed)
        } else {
            onCompletion?(.Success(code: result))
        }
    }
    
}

extension SignInWithAppleWebAuthView: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        logger.log(navigationResponse.response.url?.absoluteString ?? "nil")
        if let currentUrl = navigationResponse.response.url {
            if currentUrl.absoluteString.starts(with: configuration.redirectUri) {
                handleRedirectUri(url: currentUrl.absoluteString)
                decisionHandler(.cancel)
                hide()
                return
            }
        }
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        logger.log(navigationAction.request.url?.absoluteString ?? "nil")
        if let currentUrl = navigationAction.request.url {
            if currentUrl.absoluteString.starts(with: configuration.redirectUri) {
                handleRedirectUri(url: currentUrl.absoluteString)
                decisionHandler(.cancel)
                hide()
                return
            }
        }
        decisionHandler(.allow)
    }
    
    
}

extension SignInWithAppleWebAuthView: WKUIDelegate {
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            guard let url = navigationAction.request.url else { return nil }
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        return nil
    }
    
}
