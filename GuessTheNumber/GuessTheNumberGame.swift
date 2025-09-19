import Foundation

struct GuessTheNumberGame {
    // MARK: - Data
    private(set) var chosenNumber: Int?
    private(set) var lowerBound: Int
    private(set) var upperBound: Int
    private(set) var attemptsCount: Int
    private(set) var attemptsList: [Int]
    private(set) var didGuessCorrectly: Bool
    private(set) var isLiar: Bool
    private(set) var currentGuess: Int?
    private(set) var showGuessButton: Bool

    // MARK: - Init
    init() {
        self.chosenNumber = nil //nulo, o int? possibilita valores nulos
        self.lowerBound = 1
        self.upperBound = 100
        self.attemptsCount = 0
        self.attemptsList = []
        self.didGuessCorrectly = false
        self.isLiar = false
        self.currentGuess = nil
        self.showGuessButton = true
    }

    // MARK: - Logic & Actions
    //OBS: As funções tem esses mutating pois as funcoes nao tem permissao para alterar variaveis do struct, o que permite isso é o mutating
    mutating func confirmChosenNumber(_ number: Int) {
        self.chosenNumber = number
    }

    func isChosenNumberValid() -> Bool {
        guard let number = chosenNumber else { return false }
        return number >= lowerBound && number <= upperBound
    }

    mutating func generateCalculatedGuess() -> Int {
        let guess = (lowerBound + upperBound) / 2
        currentGuess = guess
        incrementAttempt(with: guess)
        showGuessButton = false
        return guess
    }

    mutating func numberIsLowerThanGuess() {
        if let guess = currentGuess {
            upperBound = guess - 1
        }
    }

    mutating func numberIsHigherThanGuess() {
        if let guess = currentGuess {
            lowerBound = guess + 1
        }
    }

    mutating func guessedCorrectly() {
        didGuessCorrectly = true
    }

    mutating func restart() {
        chosenNumber = nil
        lowerBound = 1
        upperBound = 100
        attemptsCount = 0
        attemptsList.removeAll()
        didGuessCorrectly = false
        isLiar = false
        currentGuess = nil
        showGuessButton = true
    }

    mutating func checkIfLiar() {
        guard let number = chosenNumber else { return }
        if lowerBound > number || upperBound < number {
            isLiar = true
        }
    }

    // MARK: - Helpers
    private mutating func incrementAttempt(with guess: Int) {
        attemptsCount += 1
        attemptsList.append(guess)
    }
}
