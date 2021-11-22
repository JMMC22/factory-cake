//
//  Sequence+uniqued.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 22/11/21.
//

import Foundation

extension Array where Element: Hashable {
    func uniqued() -> Array {
        return Array(Set(self))
    }
}
