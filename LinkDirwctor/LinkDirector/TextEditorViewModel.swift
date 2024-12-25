//
//  TextEditorViewModel.swift
//  LinkDirwctor
//
//  Created by Sheikh Abu mohamed on 22/12/24.
//

import SwiftUI

class TextEditorViewModel: ObservableObject {
    @Published var text: String = "" // The editable text
    @Published var isKeyboardVisible: Bool = false // Tracks keyboard visibility
    
    func handleLinkTap(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

