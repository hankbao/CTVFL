//
//  CTVFLPredication.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public protocol CTVFLPredicating: CTVFLVisualFormatConvertible { }

public protocol CTVFLEqualLiteralPredicating: CTVFLPredicating, CTVFLPredicate { }

extension CTVFLEqualLiteralPredicating where Self: CustomStringConvertible {
    public func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        return "\(self.description)"
    }
}

extension Int: CTVFLEqualLiteralPredicating {}

extension Float: CTVFLEqualLiteralPredicating {}

extension Double: CTVFLEqualLiteralPredicating {}

extension CGFloat: CTVFLEqualLiteralPredicating {}

public struct CTVFLPredication<P: CTVFLPredicate>: CTVFLPredicating {
    internal typealias _Predicate = P
    
    internal enum _Relation: CustomStringConvertible {
        case equal
        case largerThanOrEqual
        case lessThanOrEqual
        
        var description: String {
            switch self {
            case .equal:                return "=="
            case .largerThanOrEqual:    return ">="
            case .lessThanOrEqual:      return "<="

            }
        }
    }
    
    internal let _priority: Priority
    
    internal let _relation: _Relation
    
    internal let _predicate: _Predicate
    
    internal init(predicate: _Predicate, relation: _Relation, priority: Priority = .required) {
        _predicate = predicate
        _relation = relation
        _priority = priority
    }
    
    internal func _byUpdatingPriority(_ priority: Priority) -> CTVFLPredication {
        return .init(predicate: _predicate, relation: _relation, priority: priority)
    }
    
    public func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let relation = _relation.description
        let predicate = _predicate._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)
        if _priority != .required {
            return "\(relation)\(predicate)@\(_priority.rawValue)"
        } else {
            return "\(relation)\(predicate)"
        }
    }
}

public prefix func <= <C: CTVFLPredicate>(predicate: C) -> CTVFLPredication<C> {
    return .init(predicate: predicate, relation: .lessThanOrEqual)
}

public prefix func == <C: CTVFLPredicate>(predicate: C) -> CTVFLPredication<C> {
    return .init(predicate: predicate, relation: .equal)
}

public prefix func >= <C: CTVFLPredicate>(predicate: C) -> CTVFLPredication<C> {
    return .init(predicate: predicate, relation: .largerThanOrEqual)
}

// MARK: Updating Predication's Priority
public func ~ <P>(lhs: CTVFLPredication<P>, rhs: Priority) -> CTVFLPredication<P> {
    return lhs._byUpdatingPriority(rhs)
}

public func ~ <P>(lhs: CTVFLPredication<P>, rhs: Int) -> CTVFLPredication<P> {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

public func ~ <P>(lhs: CTVFLPredication<P>, rhs: Float) -> CTVFLPredication<P> {
    return lhs._byUpdatingPriority(Priority(rhs))
}

public func ~ <P>(lhs: CTVFLPredication<P>, rhs: Double) -> CTVFLPredication<P> {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

public func ~ <P>(lhs: CTVFLPredication<P>, rhs: CGFloat) -> CTVFLPredication<P> {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

// MARK: Updating Equal Literal Predicate's Priority
public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Priority) -> CTVFLPredication<P> {
    return .init(predicate: lhs, relation: .equal, priority: rhs)
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Int) -> CTVFLPredication<P> {
    return lhs ~ Priority(Float(rhs))
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Float) -> CTVFLPredication<P> {
    return lhs ~ Priority(rhs)
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Double) -> CTVFLPredication<P> {
    return lhs ~ Priority(Float(rhs))
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: CGFloat) -> CTVFLPredication<P> {
    return lhs ~ Priority(Float(rhs))
}
