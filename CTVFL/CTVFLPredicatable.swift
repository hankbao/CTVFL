//
//  CTVFLPredicatable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: - Predicate
public protocol CTVFLPredicatable {
    func that(_ predicates: CTVFLPredicating...) -> CTVFLPredicatedVariable
}

extension View: CTVFLPredicatable {
    public func that(
        _ predicates: CTVFLPredicating...
        ) -> CTVFLPredicatedVariable
    {
        return .init(variable: .init(rawValue: self), predicates: predicates)
    }
}

public class CTVFLPredicatedVariable: CTVFLEdgeToEdgeLexicon, CTVFLSpacedLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    internal let _variable: CTVFLVariable
    
    internal let _predicates: [CTVFLPredicating]
    
    internal init(variable: CTVFLVariable, predicates: [CTVFLPredicating]) {
        _variable = variable
        _predicates = predicates
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let variable = _variable._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)
        let predicates = _predicates
            .map({$0._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)})
            .joined(separator: ",")
        if parenthesizesVariables {
            return "[\(variable)(\(predicates))]"
        } else {
            return "\(variable)(\(predicates))"
        }
    }
}
