//
//  CTVFL.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

public typealias CTVFLVariable = View

// MARK: - Make and Install Constraint Group
@discardableResult
public func constrain(
    toReplace gruop: CTVFLConstraintGroup? = nil,
    using closure: () -> Void
    ) -> CTVFLConstraintGroup
{
    let repacingGroup = gruop ?? CTVFLConstraintGroup()
    let globalContext = CTVFLGlobalContext.push()
    closure()
    let constraints = globalContext.constraints
    CTVFLGlobalContext.pop()
    repacingGroup._replaceConstraints(constraints)
    return repacingGroup
}

// MARK: - Setting Variable Name
public func setVariableName(
    _ variableName: String,
    for variable: CTVFLVariable
    )
{
    if let sahredContext = CTVFLGlobalContext.shared {
        sahredContext.setOverridingName(variableName, for: variable)
    } else {
        debugPrint(
            """
            Since there is no active global context, setting Compile-Time
             Visual Format Language's variable \(variable) with name
             \"\(variableName)\" didn't have any work.
            """
        )
    }
}

// MARK: - Building Inline VFL Block
@discardableResult
public func withVFL(
    V verticalDescription: @autoclosure ()-> CTVFLVisualFormatConvertible,
    options: VFLOptions = []
    ) -> [NSLayoutConstraint]
{
    let inlineContext = CTVFLInlineContext._push()
    let outputable = verticalDescription()
    let visualFormat = _makeVisualFormat(
        with: outputable,
        inlineContext: inlineContext,
        orientation: .vertical
    )
    CTVFLInlineContext._pop()
    let constraints = Constraint.constraints(
        withVisualFormat: visualFormat,
        options: options,
        metrics: nil,
        views: inlineContext._variables
    )
    if let globalContext = CTVFLGlobalContext.shared {
        globalContext.registerConstraints(constraints, with: inlineContext._variables.values)
    }
    return constraints
}

@discardableResult
public func withVFL(
    H horizontalDescription: @autoclosure ()-> CTVFLVisualFormatConvertible,
    options: VFLOptions = []
    ) -> [NSLayoutConstraint]
{
    let inlineContext = CTVFLInlineContext._push()
    let outputable = horizontalDescription()
    let visualFormat = _makeVisualFormat(
        with: outputable,
        inlineContext: inlineContext,
        orientation: .horizontal
    )
    CTVFLInlineContext._pop()
    let constraints = Constraint.constraints(
        withVisualFormat: visualFormat,
        options: options,
        metrics: nil,
        views: inlineContext._variables
    )
    if let globalContext = CTVFLGlobalContext.shared {
        globalContext.registerConstraints(constraints, with: inlineContext._variables.values)
    }
    return constraints
}

// MARK: - Controlling Tralsation from Autoresizing Mask into Constraints
private var _ignoresTranslatingAutoresizingMaskIntoConstraints_ = false

public var ignoresTranslatingAutoresizingMaskIntoConstraints: Bool {
    get {
        _assert(Thread.isMainThread)
        return _ignoresTranslatingAutoresizingMaskIntoConstraints_
    }
    set {
        _assert(Thread.isMainThread)
        _ignoresTranslatingAutoresizingMaskIntoConstraints_ = newValue
    }
}

// MARK: Oeprators
precedencegroup CTVFLPriorityModifyPrecedence {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: AssignmentPrecedence
}

infix operator ~ : CTVFLPriorityModifyPrecedence

prefix operator <=

prefix operator >=

prefix operator ==

prefix operator |-

postfix operator -|

prefix operator |

postfix operator |

