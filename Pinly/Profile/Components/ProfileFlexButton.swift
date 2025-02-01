import SwiftUI

struct ProfileFlexButton: View {
    let buttonTitle: String
    let action: () -> Void
    
    init(buttonTitle: String, action: @escaping () -> Void = {}) {
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    var body: some View {
        Text(buttonTitle)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(Color.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1)
            }
    }
}
