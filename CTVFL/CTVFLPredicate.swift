//
//  CTVFLPredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public protocol CTVFLPredicate: CTVFLVisualFormatConvertible {}

public protocol CTVFLLiteralPredicate: CTVFLPredicate {}

extension Int: CTVFLLiteralPredicate {}

extension Float: CTVFLLiteralPredicate {}

extension Double: CTVFLLiteralPredicate {}

extension CGFloat: CTVFLLiteralPredicate {}

