//
//  CTVFLVariantPredicateObject.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

public enum CTVFLVariantPredicateObject {
    case constant(CTVFLConstant)
    case variable(CTVFLVariable)
    
    public func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
    {
        switch self {
        case let .constant(c):
            return c.description
        case let .variable(v):
            return inlineContext._ensureName(for: v)
        }
    }
}
