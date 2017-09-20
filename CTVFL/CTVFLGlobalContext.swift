//
//  CTVFLGlobalContext.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import Foundation

internal class CTVFLGlobalContext {
    // MARK: Stores Variable Names
    internal func setOverridingName(_ name: String, for variable: CTVFLVariable) {
        overridingNameForVariable[variable] = name
    }
    
    internal func overridingName(for variable: CTVFLVariable) -> String? {
        if let existedName = overridingNameForVariable[variable] {
            return existedName
        } else {
            return nil
        }
    }
    
    internal var overridingNameForVariable: [CTVFLVariable : String] = [:]
    
    internal var overridingVariables: [String: CTVFLVariable] {
        var variables = [String: CTVFLVariable]()
        for (variable, name) in overridingNameForVariable {
            variables[name] = variable
        }
        return variables
    }
    
    // MARK: Stores Constraints
    internal var constraints: [CTVFLConstraint] {
        return cosntraints_
    }
    
    private var cosntraints_: [CTVFLConstraint]
    
    @discardableResult
    internal static func push() -> CTVFLGlobalContext {
        _assert(Thread.isMainThread)
        let pushed = CTVFLGlobalContext()
        contexts.append(pushed)
        return pushed
    }
    
    @discardableResult
    internal static func pop() -> CTVFLGlobalContext {
        _assert(Thread.isMainThread)
        return contexts.removeLast()
    }
    
    internal static var shared: CTVFLGlobalContext? {
        return contexts.last
    }
    
    internal static private(set) var contexts: [CTVFLGlobalContext] = []
    
    internal init() {
        _assert(Thread.isMainThread)
        cosntraints_ = []
        ignoresTranslatingAutoresizingMaskIntoConstraints = false
    }
    
    deinit {
        _assert(Thread.isMainThread)
        ignoresTranslatingAutoresizingMaskIntoConstraints = false
    }
    
    internal static func registerConstraints<C, V>(
        _ constraints: C,
        with views: V
        ) where
        C: Sequence, C.Element == Constraint,
        V: Sequence, V.Element == View
    {
        _assert(Thread.isMainThread)
        let shouldPop = shared == nil
        let context = shared ?? push()
        
        context.registerConstraints(constraints, with: views)
        
        if shouldPop {
            pop()
        }
    }
    
    internal func registerConstraints<C, V>(
        _ constraints: C,
        with views: V
        ) where
        C: Sequence, C.Element == Constraint,
        V: Sequence, V.Element == View
    {
        _assert(Thread.isMainThread)
        
        if !ignoresTranslatingAutoresizingMaskIntoConstraints {
            for eachView in views {
                if eachView.translatesAutoresizingMaskIntoConstraints {
                    eachView.translatesAutoresizingMaskIntoConstraints = false
                }
            }
        }
        
        if let hostView = views._commonAncestor {
            let installables: [CTVFLConstraint] = constraints.map {
                .init(view: hostView, constraint: $0)
            }
            cosntraints_.append(contentsOf: installables)
        } else {
            NSLog(
                """
                No common super view found for constraints:
                \(Array(constraints)). Candidates: \(views).
                """
            )
        }
    }
}
