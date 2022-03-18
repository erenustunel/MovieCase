//
//  String+Ext.swift
//  MovieCase
//
//  Created by Eren Üstünel on 14.03.2022.
//

import Foundation

extension String {
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal, range: nil)
    }
}

