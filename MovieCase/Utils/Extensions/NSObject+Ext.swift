//
//  NSObject+Ext.swift
//  MovieCase
//
//  Created by Eren Üstünel on 14.03.2022.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
