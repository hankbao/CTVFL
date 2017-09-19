//
//  CTVFLVisualFormatConvertible.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public protocol CTVFLVisualFormatConvertible {
    func _ctvfl_makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext, parenthesizesVariables: Bool) -> String
}

internal enum VisualFormatOrientation {
    case vertical
    case horizontal
}

func _makeVisualFormat(
    with outputable: CTVFLVisualFormatConvertible,
    inlineContext: CTVFLInlineContext,
    orientation: VisualFormatOrientation
    ) -> String
{
    let primitiveVisualFormat = outputable._ctvfl_makePrimitiveVisualFormat(with: inlineContext, parenthesizesVariables: true)
    switch orientation {
    case .horizontal:
        return "H:\(primitiveVisualFormat)"
    case .vertical:
        return "V:\(primitiveVisualFormat)"
    }
}
