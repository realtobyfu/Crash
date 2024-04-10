import SwiftUI

enum AlertType

struct ContentView: View {
    @State private var betSize: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var game = Game()
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
             BackgroundView(game: $game) // Assuming this is relevant to your UI
            VStack {
                TextField("Enter tokens", text: $betSize)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Text("Current Multiplier: \(game.currentMultiplier, specifier: "%.2f")x")
                
                if game.gameStarted {
                    Button("Cash Out") {
                        cashOut()
                    }
                    .padding()
                } else {
                    Button("Start Game") {
                        startGame()
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Congrats"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func startGame() {
        guard let bet = Double(betSize), bet <= game.totalTokens else {
            alertMessage = "Your bet exceeds your total tokens or is not a valid number."
            showAlert = true
            return
        }
        
        game.startGame(bet: bet)

        let base: Double = 1.012 // Base for exponential growth of the multiplier
        let skew: Double = 107.18 // Controls the spread
        
        // Generate a random crash point
        let crashPoint = pow(base, Double.random(in: 0...skew))
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.game.currentMultiplier += 0.08
            if self.game.currentMultiplier >= crashPoint {
                self.crash()
            }
        }
    }
    
    private func cashOut() {
        let winnings = game.cashOut()
        
        // Update alert to show winnings
        alertMessage = "You just won \(winnings) tokens!\nTotal Tokens: \(game.totalTokens)"
        showAlert = true
        
        betSize = "" // Reset for the next game
        timer?.invalidate()
    }
    
    private func crash() {
        game.crash()
        betSize = "" // Reset bet size
        timer?.invalidate()
    }
}
