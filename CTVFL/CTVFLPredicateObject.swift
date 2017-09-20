//
//  CTVFLPredicateObject.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public protocol CTVFLPredicateObject: CTVFLVisualFormatConvertible {}

extension Int: CTVFLPredicateObject {}

extension Float: CTVFLPredicateObject {}

extension Double: CTVFLPredicateObject {}

extension CGFloat: CTVFLPredicateObject {}

