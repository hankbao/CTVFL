//
//  CTVFLVariable.swift
//  CTVFL
//
//  Created by Yu-Long Li on 9/20/17.
//

public struct CTVFLVariable: RawRepresentable,
    Hashable,
    CTVFLPredicate,
    CTVFLEdgeToEdgeLexicon,
    CTVFLSpacedLexicon
{
    public typealias RawValue = View
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    internal var _view: View { return rawValue }
    
    // MARK: Hashable
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public static func == (lhs: CTVFLVariable, rhs: CTVFLVariable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
    
    // MARK: CTVFLEdgeToEdgeLexicon
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        let name = inlineContext._ensureName(for: self)
        if parenthesizesVariables {
            return "[\(name)]"
        } else {
            return name
        }
    }
}
