//
//  CTVFLPredicateTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLPredicateTests: XCTestCase {
    // MARK: Testing <=
    func testLessThanOrEqualPredicateWithIntegerLiteral() {
        let predicate = <=1
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(1.0)")
    }
    
    func testLessThanOrEqualPredicateWithFloatLiteral() {
        let predicate = <=1.0
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(1.0)")
    }
    
    func testLessThanOrEqualPredicateWithInt() {
        let value = Int(1)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(1.0)")
    }
    
    func testLessThanOrEqualPredicateWithDouble() {
        let value = Double(1.0)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(value)")
    }
    
    func testLessThanOrEqualPredicateWithFloat() {
        let value = Float(1.0)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(value)")
    }
    
    func testLessThanOrEqualPredicateWithCGFloat() {
        let value = CGFloat(1.0)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(value)")
    }
    
    // MARK: Testing ==
    func testEqualPredicateWithIntegerLiteral() {
        let predicate = ==1
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(1.0)")
    }
    
    func testEqualPredicateWithFloatLiteral() {
        let predicate = ==1.0
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(1.0)")
    }
    
    func testEqualPredicateWithInt() {
        let value = Int(1)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(1.0)")
    }
    
    func testEqualPredicateWithDouble() {
        let value = Double(1.0)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(value)")
    }
    
    func testEqualPredicateWithFloat() {
        let value = Float(1.0)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(value)")
    }
    
    func testEqualPredicateWithCGFloat() {
        let value = CGFloat(1.0)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(value)")
    }
    
    // MARK: Testing >=
    func testGreaterThanOrEqualPredicateWithIntegerLiteral() {
        let predicate = >=1
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(1.0)")
    }
    
    func testGreaterThanOrEqualPredicateWithFloatLiteral() {
        let predicate = >=1.0
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(1.0)")
    }
    
    func testGreaterThanOrEqualPredicateWithInt() {
        let value = Int(1)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(1.0)")
    }
    
    func testGreaterThanOrEqualPredicateWithDouble() {
        let value = Double(1.0)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(value)")
    }
    
    func testGreaterThanOrEqualPredicateWithFloat() {
        let value = Float(1.0)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(value)")
    }
    
    func testGreaterThanOrEqualPredicateWithCGFloat() {
        let value = CGFloat(1.0)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(value)")
    }
}
