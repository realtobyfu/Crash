import Foundation

struct Game {
    var totalTokens: Double = 1000.0
    var betSize: Double = 0
    var currentMultiplier: Double = 1.0
    var gameStarted = false
    
    // Method to initialize a new game or round
    mutating func startGame(bet: Double) {
        self.betSize = bet
        self.totalTokens -= bet
        self.currentMultiplier = 1.0
        self.gameStarted = true
    }
    
    // Method to handle cashing out
    mutating func cashOut() -> Double {
        var winnings = betSize * currentMultiplier
        winnings = (winnings * 100).rounded() / 100

        totalTokens += winnings
        gameStarted = false
        return winnings
    }
    
    // Method to handle game crash
    mutating func crash() {
        gameStarted = false
        // Reset the bet size for safety, but could be adjusted based on game design
        betSize = 0
    }
}
