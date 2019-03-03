//
//  IBOutletRewriter.swift
//  SwiftOptimizerCore
//
//  Created by Yusuke Kita on 03/03/19.
//

import Foundation
import SwiftSyntax

public class IBOutletRewriter: SyntaxRewriter {
    
    override public func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        // ignore if no @IBOutlet
        guard let attributes = node.attributes,
            attributes.contains(where: { $0.attributeName.tokenKind == .IBOutletKind }) else {
                return super.visit(node)
        }
        
        // ignore if private is already added
        guard let modifiers = node.modifiers,
            !modifiers.contains(where: { $0.name.tokenKind == .privateKeyword }) else {
                return super.visit(node)
        }
        
        let newModifiers = modifiers.inserting(.init({ (builder) in
            builder.addToken(SyntaxFactory.makePrivateKeyword(leadingTrivia: .noSpace, trailingTrivia: .oneSpace))
        }), at: 0)
        let newNode = node.withModifiers(newModifiers)
        
        return super.visit(newNode)
    }
}
