//
//  protocols.swift
//  GetItDone
//
//  Created by Станислав on 28.10.2020.
//

import Foundation

protocol GDHeaderDelegate {
    func openAddItemPopup()
}

protocol GDNewItemDelegate {
    func addItemToList(text: String)
}
