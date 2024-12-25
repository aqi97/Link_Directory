import SwiftUI

struct TextEditorView: View {
    @StateObject private var viewModel = TextEditorViewModel()
    @FocusState private var isEditorFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // "Not Paid" label
                Text("Not Paid")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.red)
                    .cornerRadius(12)
                    .padding(.top, 16)
                
                Spacer(minLength: 16)
                
                // Text Editor with Border
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1.5)
                        .padding(.horizontal, 8)
                    
                    TextEditor(text: $viewModel.text)
                        .focused($isEditorFocused)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(12)
                        .placeholder(when: viewModel.text.isEmpty, placeholder: "Enter your text here...")
                        .onChange(of: isEditorFocused) { focused in
                            viewModel.isKeyboardVisible = focused
                        }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            
            if !viewModel.isKeyboardVisible {
                LinkOverlayView(
                    text: viewModel.text,
                    onTapLink: { url in
                        viewModel.handleLinkTap(url)
                        isEditorFocused = false
                    },
                    onTapText: { position in
                        isEditorFocused = true
                    }
                )
            }
        }
    }
}

extension View {
    func placeholder(when shouldShow: Bool, placeholder: String) -> some View {
        ZStack(alignment: .topLeading) {
            if shouldShow {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
            }
            self
        }
    }
}

#Preview {
    TextEditorView()
}
