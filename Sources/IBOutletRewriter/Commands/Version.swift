//
//  Version.swift
//  IBOutletRewriter
//
//  Created by Yusuke Kita on 04/11/19.
//

import Foundation
import Commandant
import Result

struct VersionCommand: CommandProtocol {
    
    typealias Options = NoOptions<AnyError>
    
    let verb = "version"
    let function = "Display current version of IBOutletRewriter"
    
    func run(_ options: Options) -> Result<(), AnyError> {
        print("0.2.0")
        return .init(value: ())
    }
}
