//
//  CTVFLConnectable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

// MARK: - Connectable
internal enum CTVFLConnectionSpace: CustomStringConvertible {
    case system
    case null
    
    internal var description: String {
        switch self {
        case .system:   return "-"
        case .null:     return ""
        }
    }
}

public protocol CTVFLConnectable: CTVFLVisualFormatConvertible {
    
}

public protocol CTVFLConnectableLiteral: CTVFLConnectable {
    
}

public protocol CTVFLConnectableVariable: CTVFLConnectable {
    
}

extension Int: CTVFLConnectableLiteral {}

extension Float: CTVFLConnectableLiteral {}

extension Double: CTVFLConnectableLiteral {}

extension CGFloat: CTVFLConnectableLiteral {}

extension View: CTVFLConnectableVariable {}

public struct CTVFLConnectedObject: CTVFLConnectable, CTVFLVisualFormatConvertible {
    internal let _lhs: CTVFLConnectable
    
    internal let _rhs: CTVFLConnectable
    
    internal let _spacing: CTVFLConnectionSpace
    
    internal init(lhs: CTVFLConnectable, rhs: CTVFLConnectable, spacing: CTVFLConnectionSpace) {
        _lhs = lhs
        _rhs = rhs
        _spacing = spacing
    }
    
    public func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let lhs = _lhs._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        let rhs = _rhs._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        let spacing = _spacing.description
        return "\(lhs)\(spacing)\(rhs)"
    }
}

public func - (lhs: CTVFLConnectable, rhs: CTVFLConnectable) -> CTVFLConnectedObject {
    return .init(lhs: lhs, rhs: rhs, spacing: .system)
}

public func | (lhs: CTVFLConnectable, rhs: CTVFLConnectable) -> CTVFLConnectedObject {
    return .init(lhs: lhs, rhs: rhs, spacing: .null)
}

// MARK: - Edge Connectable
public protocol CTVFLEdgeConnectable: CTVFLConnectable {
    
}

public struct CTVFLEdgeConnectedObject: CTVFLConnectable, CTVFLVisualFormatConvertible {
    internal enum _Side: Int {
        case leading
        case trailing
    }
    
    internal let _side: _Side
    
    internal let _object: CTVFLEdgeConnectable
    
    internal let _space: CTVFLConnectionSpace
    
    internal init(object: CTVFLEdgeConnectable, side: _Side, space: CTVFLConnectionSpace) {
        _object = object
        _side = side
        _space = space
    }
    
    public func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let object = _object._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: parenthesizesVariables)
        let space = _space.description
        let leading = (_side == .leading) ? "|\(space)" : ""
        let trailing = (_side == .trailing) ? "\(space)|" : ""
        return "\(leading)\(object)\(trailing)"
    }
}

extension View: CTVFLEdgeConnectable {}

extension CTVFLPredicatedObject: CTVFLEdgeConnectable {}

public prefix func |- (operand: CTVFLEdgeConnectable) -> CTVFLEdgeConnectedObject {
    return .init(object: operand, side: .leading, space: .system)
}

public prefix func | (operand: CTVFLEdgeConnectable) -> CTVFLEdgeConnectedObject {
    return .init(object: operand, side: .leading, space: .null)
}

public postfix func -| (operand: CTVFLEdgeConnectable) -> CTVFLEdgeConnectedObject {
    return .init(object: operand, side: .trailing, space: .system)
}

public postfix func | (operand: CTVFLEdgeConnectable) -> CTVFLEdgeConnectedObject {
    return .init(object: operand, side: .trailing, space: .null)
}
