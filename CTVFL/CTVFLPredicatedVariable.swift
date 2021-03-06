//
//  CTVFLPredicatedVariable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public class CTVFLPredicatedVariable: CTVFLEdgeToEdgeLexicon,
    CTVFLSpacedLexicon
{
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    internal let _variable: CTVFLVariable
    
    internal let _predicates: [CTVFLPredicating]
    
    internal init(
        variable: CTVFLVariable,
        predicates: [CTVFLPredicating]
        )
    {
        _variable = variable
        _predicates = predicates
    }
    
    public func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
    {
        let variableName = inlineContext._ensureName(for: _variable)
        let predicates = _predicates
            .map({$0._toCTVFLPredicate()})
            .map({$0.makePrimitiveVisualFormat(with: inlineContext)})
            .joined(separator: ",")
        return "[\(variableName)(\(predicates))]"
    }
}
