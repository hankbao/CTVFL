//
//  CTVFLPredicatable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: - Predicate
public protocol CTVFLPredicatable {
    func that(_ predications: CTVFLPredicationProtocol...) -> CTVFLPredicatedVariable
}

extension View: CTVFLPredicatable {
    public func that(
        _ predications: CTVFLPredicationProtocol...
        ) -> CTVFLPredicatedVariable
    {
        return .init(variable: .init(rawValue: self), predications: predications)
    }
}

public class CTVFLPredicatedVariable: CTVFLEdgeToEdgeLexicon, CTVFLSpacedLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    internal let _variable: CTVFLVariable
    
    internal let _predications: [CTVFLPredicationProtocol]
    
    internal init(variable: CTVFLVariable, predications: [CTVFLPredicationProtocol]) {
        _variable = variable
        _predications = predications
    }
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let variable = _variable._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)
        let predications = _predications
            .map({$0._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: false)})
            .joined(separator: ",")
        if parenthesizesVariables {
            return "[\(variable)(\(predications))]"
        } else {
            return "\(variable)(\(predications))"
        }
    }
}
