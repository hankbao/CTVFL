//
//  CTVFLPredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public protocol CTVFLPredicate: CTVFLVisualFormatConvertible {
    
}

public protocol CTVFLLiteralPredicate: CTVFLPredicate {
    
}

extension Int: CTVFLLiteralPredicate {}

extension Float: CTVFLLiteralPredicate {}

extension Double: CTVFLLiteralPredicate {}

extension CGFloat: CTVFLLiteralPredicate {}

extension View: CTVFLPredicate {
    public func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let name = inlineContext._ensureName(for: self)
        if parenthesizesVariables {
            return "[\(name)]"
        } else {
            return name
        }
    }
}

