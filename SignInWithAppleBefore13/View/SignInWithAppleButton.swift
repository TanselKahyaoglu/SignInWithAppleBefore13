//
//  SignInWithAppleButton.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation
import UIKit

public class SignInWithAppleButton: UIButton {
    
    //Styles of button
    public enum SignInWithAppleButtonStyle: Int {
        case White = 0, Black = 1
    }
    
    //Default style is white
    @IBInspectable
    var style: Int = 0 {
        didSet {
            buttonStyle = SignInWithAppleButtonStyle(rawValue: style) ?? .White
        }
    }
    
    private var configuration: SignInWithAppleConfiguration?
    public var buttonStyle: SignInWithAppleButtonStyle = .White
    
    public var onCompletion: ((SignInWithAppleResult)->Void)?
    
    
    //Clear all button functions
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle("", for: state)
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
    
    }
    
    public override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        
    }
    
    public override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        
    }
    
    public override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        makeDefaultSettings()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeDefaultSettings()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeDefaultSettings()
    }
    
    //Give default values
    private func makeDefaultSettings() {
        super.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        super.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        configureButtonStyle()
    }
    
    //Set Configuration File
    public func setConfiguration(_ configuration: SignInWithAppleConfiguration) {
        self.configuration = configuration
    }
    
    private func configureButtonStyle() {
        if buttonStyle == .White {
            super.setBackgroundImage(UIImage(named:"btn_sign_white", in:  Bundle(for: type(of: self)), compatibleWith:nil), for: .normal)
        } else {
            super.setBackgroundImage(UIImage(named:"btn_sign_black", in:  Bundle(for: type(of: self)), compatibleWith:nil), for: .normal)
        }
    }
    
    @objc
    private func actionButton(_ sender: Any?) {
        showAuthPage()
    }
    
    private func showAuthPage() {
        guard let configuration = configuration else { return }
        let signInWithAppleView = SignInWithAppleWebAuthView(configuration: configuration)
        signInWithAppleView.show() { [weak self] result in
            guard let self = self else { return }
            self.onCompletion?(result)
        }
    }
    
}
