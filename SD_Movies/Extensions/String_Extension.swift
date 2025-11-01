//  String_Extension.swift
//  SD_Movies
//  Created by Miguel Gallego on 2/11/25.
import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
