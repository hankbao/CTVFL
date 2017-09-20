//
//  CTVFLPredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public protocol CTVFLPredicating: CTVFLVisualFormatConvertible { }

public protocol CTVFLEqualLiteralPredicating: CTVFLPredicating,
CTVFLPredicateObject { }

extension Int: CTVFLEqualLiteralPredicating {}

extension Float: CTVFLEqualLiteralPredicating {}

extension Double: CTVFLEqualLiteralPredicating {}

extension CGFloat: CTVFLEqualLiteralPredicating {}

public struct CTVFLPredicate<P: CTVFLPredicateObject>: CTVFLPredicating, CTVFLSpacedLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
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
    
    internal func _byUpdatingPriority(_ priority: Priority) -> CTVFLPredicate {
        return .init(predicate: _predicate, relation: _relation, priority: priority)
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let relation = _relation.description
        let predicate = _predicate._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)
        if _priority != .required {
            return "\(relation)\(predicate)@\(_priority.rawValue)"
        } else {
            return "\(relation)\(predicate)"
        }
    }
}

public prefix func <= <C: CTVFLPredicateObject>(predicate: C) -> CTVFLPredicate<C> {
    return .init(predicate: predicate, relation: .lessThanOrEqual)
}

public prefix func == <C: CTVFLPredicateObject>(predicate: C) -> CTVFLPredicate<C> {
    return .init(predicate: predicate, relation: .equal)
}

public prefix func >= <C: CTVFLPredicateObject>(predicate: C) -> CTVFLPredicate<C> {
    return .init(predicate: predicate, relation: .largerThanOrEqual)
}

// MARK: Updating Predication's Priority
public func ~ <P>(lhs: CTVFLPredicate<P>, rhs: Priority) -> CTVFLPredicate<P> {
    return lhs._byUpdatingPriority(rhs)
}

public func ~ <P>(lhs: CTVFLPredicate<P>, rhs: Int) -> CTVFLPredicate<P> {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

public func ~ <P>(lhs: CTVFLPredicate<P>, rhs: Float) -> CTVFLPredicate<P> {
    return lhs._byUpdatingPriority(Priority(rhs))
}

public func ~ <P>(lhs: CTVFLPredicate<P>, rhs: Double) -> CTVFLPredicate<P> {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

public func ~ <P>(lhs: CTVFLPredicate<P>, rhs: CGFloat) -> CTVFLPredicate<P> {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

// MARK: Updating Equal Literal Predicate's Priority
public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Priority) -> CTVFLPredicate<P> {
    return .init(predicate: lhs, relation: .equal, priority: rhs)
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Int) -> CTVFLPredicate<P> {
    return lhs ~ Priority(Float(rhs))
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Float) -> CTVFLPredicate<P> {
    return lhs ~ Priority(rhs)
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: Double) -> CTVFLPredicate<P> {
    return lhs ~ Priority(Float(rhs))
}

public func ~ <P: CTVFLEqualLiteralPredicating>(lhs: P, rhs: CGFloat) -> CTVFLPredicate<P> {
    return lhs ~ Priority(Float(rhs))
}
