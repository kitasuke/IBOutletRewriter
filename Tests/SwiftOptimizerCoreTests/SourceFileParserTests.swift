//
//  SourceFileParserTests.swift
//  SwiftOptimizerCoreTests
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import XCTest
@testable import SwiftOptimizerCore

final class SourceFileParserTests: XCTestCase {
    
    func testEmptyPath() {
        do {
            _ = try SourceFileParser(path: "")
            XCTFail("empty path is not acceptable")
        } catch {
            
        }
    }
    
    func testValidPath() {
        let path = "/Users"
        do {
            _ = try SourceFileParser(path: path)
        } catch {
            XCTFail("\(path) is invalid")
        }
    }
}
