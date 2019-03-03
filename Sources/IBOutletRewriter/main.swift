//
//  main.swift
//  IBOutletRewriter
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import Result
import Commandant

let registry = CommandRegistry<AnyError>()

registry.register(RunCommand())
let helpCommand = HelpCommand(registry: registry)
registry.register(helpCommand)

registry.main(defaultVerb: helpCommand.verb) { error in
    fputs("\(error)\n", stderr)
}
