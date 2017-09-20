//
//  CTVFLVisualFormat.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public protocol CTVFLVisualFormatConvertible {
    
    func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String
}

extension CTVFLVisualFormatConvertible where Self: CustomStringConvertible {
    public func _makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String {
        return "\(self.description)"
    }
}

internal enum VisualFormatOrientation {
    case vertical
    case horizontal
}

internal func _makeVisualFormat<T: CTVFLLexicon>(
    with lexicon: T,
    inlineContext: CTVFLInlineContext,
    orientation: VisualFormatOrientation
    ) -> String
{
    let primitiveVisualFormat = lexicon._makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: true)
    switch orientation {
    case .horizontal:
        return "H:\(primitiveVisualFormat)"
    case .vertical:
        return "V:\(primitiveVisualFormat)"
    }
}
