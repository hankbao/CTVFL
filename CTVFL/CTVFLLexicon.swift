//
//  CTVFLLexicon.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public prefix func | <L>(operand: L) -> CTVFLLeadingSyntax<L> {
    return .init(lexicon: operand)
}

public prefix func | (operand: View) -> CTVFLLeadingSyntax<CTVFLVariable> {
    return .init(lexicon: .init(rawValue: operand))
}

public prefix func | <L>(operand: CTVFLTrailingSyntax<L>) -> CTVFLBracketedVariable<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: false)
}

public prefix func | <L>(operand: CTVFLSpacedTrailingSyntax<L>) -> CTVFLBracketedSpacedVariable<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: false)
}

public postfix func | <L>(operand: L) -> CTVFLTrailingSyntax<L> {
    return .init(lexicon: operand)
}

public postfix func | (operand: View) -> CTVFLTrailingSyntax<CTVFLVariable> {
    return .init(lexicon: .init(rawValue: operand))
}

public prefix func |- <L>(operand: L) -> CTVFLSpacedLeadingSyntax<L> {
    return .init(lexicon: operand)
}

public prefix func |- (operand: View) -> CTVFLSpacedLeadingSyntax<CTVFLVariable> {
    return .init(lexicon: .init(rawValue: operand))
}

public prefix func |- <L>(operand: CTVFLTrailingSyntax<L>) -> CTVFLBracketedVariable<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: true)
}

public prefix func |- <L>(operand: CTVFLSpacedTrailingSyntax<L>) -> CTVFLBracketedSpacedVariable<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: true)
}

public postfix func -| <L>(operand: L) -> CTVFLSpacedTrailingSyntax<L> {
    return .init(lexicon: operand)
}

public postfix func -| (operand: View) -> CTVFLSpacedTrailingSyntax<CTVFLVariable> {
    return .init(lexicon: .init(rawValue: operand))
}

public func - <L1, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, L2> where L1._LastLexiconType == CTVFLLexiconConstantType, L2._FirstLexiconType == CTVFLLexiconVariableType {
    return .init(lhs: lhs, rhs: rhs)
}

public func - <L1, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, L2> where L1._LastLexiconType == CTVFLLexiconVariableType, L2._FirstLexiconType == CTVFLLexiconConstantType {
    return .init(lhs: lhs, rhs: rhs)
}

public func - <L1, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, L2> where L1._LastLexiconType == CTVFLLexiconVariableType, L2._FirstLexiconType == CTVFLLexiconVariableType {
    return .init(lhs: lhs, rhs: rhs)
}

public func - <L>(lhs: View, rhs: L) -> CTVFLSpacedSyntax<CTVFLVariable, L> where L._LastLexiconType == CTVFLLexiconConstantType {
    return .init(lhs: .init(rawValue: lhs), rhs: rhs)
}

public func - <L>(lhs: L, rhs: View) -> CTVFLSpacedSyntax<L, CTVFLVariable> where L._FirstLexiconType == CTVFLLexiconConstantType {
    return .init(lhs: lhs, rhs: .init(rawValue: rhs))
}

public func - (lhs: View, rhs: View) -> CTVFLSpacedSyntax<CTVFLVariable, CTVFLVariable> {
    return .init(lhs: .init(rawValue: lhs), rhs: .init(rawValue: rhs))
}

public func | <L1, L2>(lhs: L1, rhs: L2) -> CTVFLEdgeToEdgeSyntax<L1, L2> {
    return .init(lhs: lhs, rhs: rhs)
}

public func | <L>(lhs: View, rhs: L) -> CTVFLEdgeToEdgeSyntax<CTVFLVariable, L> {
    return .init(lhs: .init(rawValue: lhs), rhs: rhs)
}

public func | <L>(lhs: L, rhs: View) -> CTVFLEdgeToEdgeSyntax<L, CTVFLVariable> {
    return .init(lhs: lhs, rhs: .init(rawValue: rhs))
}

public func | (lhs: View, rhs: View) -> CTVFLEdgeToEdgeSyntax<CTVFLVariable, CTVFLVariable> {
    return .init(lhs: .init(rawValue: lhs), rhs: .init(rawValue: rhs))
}

// MARK: - Abstract
// MARK: CTVFLLexiconType
public protocol CTVFLLexiconType {}

public struct CTVFLLexiconConstantType: CTVFLLexiconType {}

public struct CTVFLLexiconVariableType: CTVFLLexiconType {}

// MARK: CTVFLSyntaxState
public protocol CTVFLSyntaxState {}

public struct CTVFLSyntaxNotTerminated: CTVFLSyntaxState {}

public struct CTVFLSyntaxTerminated: CTVFLSyntaxState {}

// MARK: CTVFLLexicon
public protocol CTVFLLexicon: CTVFLVisualFormatConvertible {
    associatedtype _FirstLexiconType: CTVFLLexiconType
    
    associatedtype _LastLexiconType: CTVFLLexiconType
    
    associatedtype _SyntaxState: CTVFLSyntaxState
}

extension Int: CTVFLLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
}

extension Float: CTVFLLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
}

extension Double: CTVFLLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
}

extension CGFloat: CTVFLLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
}

// MARK: CTVFLEdgeToEdgeLexicon
public protocol CTVFLEdgeToEdgeLexicon: CTVFLLexicon {}

// MARK: CTVFLSpacedLexicon
public protocol CTVFLSpacedLexicon: CTVFLLexicon {}

extension Int: CTVFLSpacedLexicon {}

extension Float: CTVFLSpacedLexicon {}

extension Double: CTVFLSpacedLexicon {}

extension CGFloat: CTVFLSpacedLexicon {}

// MARK: - Concrete
public struct CTVFLLeadingSyntax<L: CTVFLEdgeToEdgeLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lexicon = _lexicon._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "|\(lexicon)"
    }
}

public struct CTVFLTrailingSyntax<L: CTVFLEdgeToEdgeLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxTerminated
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lexicon = _lexicon._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "\(lexicon)|"
    }
}

public struct CTVFLSpacedLeadingSyntax<L: CTVFLSpacedLexicon>:
    CTVFLLexicon
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lexicon = _lexicon._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "|-\(lexicon)"
    }
}

public struct CTVFLSpacedTrailingSyntax<L: CTVFLSpacedLexicon>:
    CTVFLLexicon
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = CTVFLSyntaxTerminated
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lexicon = _lexicon._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "\(lexicon)-|"
    }
}

public struct CTVFLSpacedSyntax<L1: CTVFLLexicon, L2: CTVFLLexicon>:
    CTVFLLexicon where L1._SyntaxState == CTVFLSyntaxNotTerminated
{
    internal typealias _Lexicon1 = L1
    
    internal typealias _Lexicon2 = L2
    
    public typealias _FirstLexiconType = L1._FirstLexiconType
    
    public typealias _LastLexiconType = L2._LastLexiconType
    
    public typealias _SyntaxState = L2._SyntaxState
    
    internal let _lhs: _Lexicon1
    
    internal let _rhs: _Lexicon2
    
    internal init(lhs: _Lexicon1, rhs: _Lexicon2) {
        _lhs = lhs
        _rhs = rhs
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lhs = _lhs._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        let rhs = _rhs._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "\(lhs)-\(rhs)"
    }
}

public struct CTVFLEdgeToEdgeSyntax<L1: CTVFLLexicon, L2: CTVFLLexicon>:
    CTVFLLexicon where
    L1._LastLexiconType == CTVFLLexiconVariableType,
    L2._LastLexiconType == CTVFLLexiconVariableType,
    L1._SyntaxState == CTVFLSyntaxNotTerminated
{
    internal typealias _Lexicon1 = L1
    
    internal typealias _Lexicon2 = L2
    
    public typealias _FirstLexiconType = L1._FirstLexiconType
    
    public typealias _LastLexiconType = L2._LastLexiconType
    
    public typealias _SyntaxState = L2._SyntaxState
    
    internal let _lhs: _Lexicon1
    
    internal let _rhs: _Lexicon2
    
    internal init(lhs: _Lexicon1, rhs: _Lexicon2) {
        _lhs = lhs
        _rhs = rhs
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lhs = _lhs._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        let rhs = _rhs._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "\(lhs)\(rhs)"
    }
}

public struct CTVFLBracketedVariable<L: CTVFLEdgeToEdgeLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _trailingSyntax: CTVFLTrailingSyntax<L>
    
    internal let _hasLeadingSpacing: Bool
    
    internal init(trailingSyntax: CTVFLTrailingSyntax<L>, hasLeadingSpacing: Bool) {
        _trailingSyntax = trailingSyntax
        _hasLeadingSpacing = hasLeadingSpacing
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let spacing = _hasLeadingSpacing ? "-" : ""
        let trailing = _trailingSyntax._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "|\(spacing)\(trailing)"
    }
}

public struct CTVFLBracketedSpacedVariable<L: CTVFLSpacedLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _trailingSyntax: CTVFLSpacedTrailingSyntax<L>
    
    internal let _hasLeadingSpacing: Bool
    
    internal init(trailingSyntax: CTVFLSpacedTrailingSyntax<L>, hasLeadingSpacing: Bool) {
        _trailingSyntax = trailingSyntax
        _hasLeadingSpacing = hasLeadingSpacing
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let spacing = _hasLeadingSpacing ? "-" : ""
        let trailing = _trailingSyntax._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        return "|\(spacing)\(trailing)"
    }
}
