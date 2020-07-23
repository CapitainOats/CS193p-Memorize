//
//  Array+Only.swift
//  Memorize
//
//  Created by Tomas Havlicek on 23/07/2020.
//  Copyright © 2020 Tomas Havlicek. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
