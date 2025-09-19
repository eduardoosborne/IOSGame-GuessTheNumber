import SwiftUI

struct ContentView: View {
    @State private var game = GuessTheNumberGame()
    @State private var message: String = "Escolha um número secreto e clique em 'Gerar palpite'."
    
    func updateMessage() {
        let guess = game.generateCalculatedGuess()
        message = "Meu palpite é \(guess). O número é maior, menor ou acertei?"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)

            if let guess = game.currentGuess {
                Text("Palpite: \(guess)")
                    .font(.title)
            }
            if game.showGuessButton == true {
                HStack {
                    Button("Gerar palpite") {
                        self.updateMessage()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            if game.showGuessButton == false {
                HStack {
                    Button("Menor") {
                        game.numberIsLowerThanGuess()
                        message = "Ok, ajustando para menor..."
                        //Temporizador + atualiza mensagem
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.updateMessage()
                        }
                    }
                    Button("Maior") {
                        game.numberIsHigherThanGuess()
                        message = "Ok, ajustando para maior..."
                        //Temporizador + atualiza mensagem
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.updateMessage()
                        }
                    }
                    Button("Acertou!") {
                        game.guessedCorrectly()
                        message = "Acertei em \(game.attemptsCount) tentativas 🎉"
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Reiniciar") {
                        game.restart()
                        message = "Escolha um número secreto e clique em 'Gerar palpite'."
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
