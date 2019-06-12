//
//  IBOutletRewriter.swift
//  IBOutletRewriterCore
//
//  Created by Yusuke Kita on 03/03/19.
//

import Foundation
import SwiftSyntax

public class VariableDeclRewriter: SyntaxRewriter {
    
    override public func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        // ignore if no @IBOutlet
        guard let attributes = node.attributes,
            attributes.contains(where: {
                guard let attribute = $0 as? AttributeSyntax else { return false }
                return attribute.attributeName.tokenKind == .IBOutletKind
            }) else {
                return super.visit(node)
        }

        let newModifiers = (node.modifiers ?? SyntaxFactory.makeModifierList([]))
            .replacingWithPrivateModifier()
            .appendingWeakModifier()
        
        let newNode = node.withModifiers(newModifiers)
        
        return super.visit(newNode)
    }
}

