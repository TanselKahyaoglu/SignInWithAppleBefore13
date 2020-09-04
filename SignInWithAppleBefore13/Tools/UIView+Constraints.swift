//
//  UIView+Constraints.swift
//  SignInWithAppleBefore13
//
//  Created by Tansel Kahyaoglu on 4.09.2020.
//  Copyright © 2020 Tansel Kahyaoglu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func pinEdgesToSuperView(edges: [NSLayoutConstraint.Attribute]) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        for edge in edges {
            pinEdgeToView(edge: edge, toView: superview)
        }
    }

    //Make giving constraint more readable
    func pinEdgeToView(edge: NSLayoutConstraint.Attribute,
                       toView: UIView,
                       toEdge: NSLayoutConstraint.Attribute? = nil,
                       constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        var toViewEdge = edge
        if let toEdge = toEdge {
            toViewEdge = toEdge
        }
        NSLayoutConstraint(item: self,
                           attribute: edge,
                           relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: toView,
                           attribute: toViewEdge,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }
    
    func setHeight(height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}

