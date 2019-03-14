//
//  VariableDeclRewriterTests.swift
//  IBOutletRewriterCoreTests
//
//  Created by Yusuke Kita on 03/03/19.
//

import Foundation
import XCTest
@testable import IBOutletRewriterCore

final class VariableDeclRewriterTests: XCTestCase {
    
    func testRewriteVariableDecl() {
        let testFixture: [(inputs: [String], expected: String)] = [
            (
                // to private
                inputs: [
                    """
                    class View {
                        @IBOutlet var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet internal var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet private var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet private(set) var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet public var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet weak var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet internal weak var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet private weak var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet private(set) weak var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet public weak var view: UIView!
                    }
                    """,
                ],
                expected:
                """
                class View {
                    @IBOutlet private weak var view: UIView!
                }
                """
            ),
            (
                // to fileprivate
                inputs: [
                    """
                    class View {
                        @IBOutlet fileprivate var view: UIView!
                    }
                    """,
                    """
                    class View {
                        @IBOutlet fileprivate weak var view: UIView!
                    }
                    """
                ],
                expected:
                """
                class View {
                    @IBOutlet fileprivate weak var view: UIView!
                }
                """
            )
        ]
        
        testFixture.forEach { inputs, expected in
            inputs.forEach { input in
                let filePathURL = createSourceFile(from: input)
                defer {
                    delete(filePathURL: filePathURL)
                }

                do {
                    let parser = SourceFileParser(pathURL: filePathURL)
                    let sourceFileSyntax = try parser.parse()
                    let output = VariableDeclRewriter().visit(sourceFileSyntax)
                    XCTAssertEqual(output.description, expected)
                } catch let error {
                    fatalError("error: \(error)")
                }
            }
        }
    }
    
    private func createSourceFile(from input: String) -> URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("swift")
        try! input.write(to: url, atomically: true, encoding: .utf8)
        
        return url
    }
    
    private func delete(filePathURL url: URL) {
        try! FileManager().removeItem(at: url)
    }
}
