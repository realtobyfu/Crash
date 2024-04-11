import SwiftUI

enum AlertType {
    case error, win, loss
}

struct ContentView: View {
    @State private var betSize: String = ""
    @State private var showAlert = false
    @State private var alertType: AlertType = .error
    @State private var alertMessage = ""
    
    @State private var game = Game()
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            BackgroundView(game: $game)
            VStack {
                
                InstructionText(text: "Eject before it crushes!")
                    .padding(.bottom, 20)
        
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
                switch alertType {
                case .error:
                    return Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                case .win:
                    return Alert(title: Text("Congratulations"), message: Text(alertMessage), dismissButton: .default(Text("OK")))

                case .loss:
                    return Alert(title: Text("Oops"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func startGame() {
        guard let bet = Double(betSize), bet <= game.totalTokens else {
            alertType = .error
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
        
        alertType = winnings > 0 ? .win : .loss
        alertMessage = winnings > 0 ? "You just won \(winnings) tokens!" : "You lost. Better luck next time!"
        alertMessage += "\nTotal Tokens: \(game.totalTokens)"

        showAlert = true
        betSize = "" // Reset for the next game
        timer?.invalidate()
    }
    
    private func crash() {
        game.crash()
        alertType = .loss
        alertMessage = "Game crashed! You lost your bet."
        showAlert = true

        betSize = "" // Reset bet size
        timer?.invalidate()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(Game()) // Assuming Game is an ObservableObject, if needed
    }
}

