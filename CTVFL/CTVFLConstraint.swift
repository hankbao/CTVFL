//
//  CTVFLConstraint.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

internal class CTVFLConstraint {
    // Set to unowned to avoid a retain cycle on the associated view.
    internal unowned var view: View
    
    internal let constraint: Constraint
    
    internal func install() {
        view.addConstraint(constraint)
    }
    
    internal func uninstall() {
        view.removeConstraint(constraint)
    }
    
    internal var isActive: Bool {
        get { return constraint.isActive }
        set { constraint.isActive = true }
    }
    
    internal init(view: View, constraint: Constraint) {
        self.view = view
        self.constraint = constraint
    }
}

