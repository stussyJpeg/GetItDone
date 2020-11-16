//
//  optionset.swift
//  GetItDone
//
//  Created by Станислав on 28.10.2020.
//

import Foundation

struct ButtonOptions: OptionSet {
    let rawValue: Int

    static let roundedText = ButtonOptions(rawValue: 1 << 0)
    static let squareIcon = ButtonOptions(rawValue: 1 << 1)
    static let squareText = ButtonOptions(rawValue: 1 << 2)
  
}


