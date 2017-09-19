//
//  CTVFLPredicatable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: - Predicate
public protocol CTVFLPredicatable: CTVFLVisualFormatConvertible {
    func that(_ predications: CTVFLPredicating...) -> CTVFLPredicatedObject
}

extension View: CTVFLPredicatable {
    public func that(
        _ predications: CTVFLPredicating...
        ) -> CTVFLPredicatedObject
    {
        return .init(object: self, predications: predications)
    }
}

public class CTVFLPredicatedObject: CTVFLConnectable, CTVFLVisualFormatConvertible {
    internal let _object: CTVFLPredicatable
    
    internal let _predications: [CTVFLPredicating]
    
    internal init(object: CTVFLPredicatable, predications: [CTVFLPredicating]) {
        _object = object
        _predications = predications
    }
    
    public func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let object = _object._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)
        let predications = _predications
            .map({$0._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)})
            .joined(separator: ",")
        if parenthesizesVariables {
            return "[\(object)(\(predications))]"
        } else {
            return "\(object)(\(predications))"
        }
    }
}
