import SwiftUI

struct CardView: View {
    let content: String
    let isFaceUp: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(isFaceUp ? .white : .cyan)
                .opacity(isFaceUp ? 1 : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(lineWidth: 2)
                )
                .overlay(
                    Text(content)
                        .font(.largeTitle)
                )
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(isFaceUp ? .white : .cyan)
                .opacity(isFaceUp ? 0 : 1)
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView: View {
    @State private var themes = [
        ["🌲", "⛺️", "⛰️", "🛶", "🌺", "🪺", "🌿"] + ["🌲", "⛺️", "⛰️", "🛶", "🌺", "🪺", "🌿"],
        ["🐚", "🌴", "🌊", "🥥", "🏖️", "🍦", "⛵️", "🪸"] +  ["🐚", "🌴", "🌊", "🥥", "🏖️", "🍦", "⛵️", "🪸"],
        ["☀️", "🌵", "🏜️", "🕶️", "🎒", "🐪"] + ["☀️", "🌵", "🏜️", "🕶️", "🎒", "🐪"]
    ]
    @State private var selectedTheme = 0
    @State private var cardsCount = 16
    @State private var isCardFaceUp: [Bool] = []
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle.bold())
                .foregroundColor(.cyan)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(0..<cardsCount, id: \.self) { index in
                        if index < themes[selectedTheme].count && index < isCardFaceUp.count {
                            CardView(content: themes[selectedTheme][index], isFaceUp: isCardFaceUp[index])
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    isCardFaceUp[index].toggle()
                                }
                        }
                    }
                }
                .foregroundColor(.cyan)
            }
            
            HStack {
                Button(action: {
                    selectedTheme = 0
                    resetGame()
                }) {
                    VStack {
                        Image(systemName: "tree.fill")
                            .font(.title)
                            .foregroundColor(.cyan)
                        Text("Forest")
                            .font(.footnote)
                            .foregroundColor(.cyan)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    selectedTheme = 1
                    resetGame()
                }) {
                    VStack {
                        Image(systemName: "sailboat.fill")
                            .font(.title)
                            .foregroundColor(.cyan)
                        Text("Sea")
                            .font(.footnote)
                            .foregroundColor(.cyan)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    selectedTheme = 2
                    resetGame()
                }) {
                    VStack {
                        Image(systemName: "sun.max.fill")
                            .font(.title)
                            .foregroundColor(.cyan)
                        Text("Desert")
                            .font(.footnote)
                            .foregroundColor(.cyan)
                    }
                }
            }
            .padding()
        }
    }
        
    func resetGame() {
        isCardFaceUp = [Bool](repeating: false, count: cardsCount)
        themes = themes.map { $0.shuffled() } 
    }
}
