//
//  Utils.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation
import UIKit

// Phantom type placeholder for undefined methods
func undefined<T>(_ message:String="",file:String=#file,function:String=#function,line: Int=#line) -> T {
    fatalError("[File: \(file),Line: \(line),Function: \(function),]: Undefined: \(message)")
}
