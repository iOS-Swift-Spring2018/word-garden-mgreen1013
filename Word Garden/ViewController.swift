//
//  ViewController.swift
//  Word Garden
//
//  Created by Michael Green on 2/1/18.
//  Copyright © 2018 mgreen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    let words = ["CODE","SWIFT","FLOWER"]
    
    var wordToGuess=""
    var lettersGuessed = ""
    
    let maxGuesses = 8
    var wrongGuessesRemaining = 8
    
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewWord()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
        
        
    }

    func createNewWord(){
        let index = Int(arc4random_uniform(UInt32(words.count)))
        wordToGuess=words[index]
    }
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed = lettersGuessed + guessedLetterField.text!
        
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord+" "+String(letter)
            } else {
                revealedWord = revealedWord+" _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text=revealedWord
    }
    
    func guessLetter() {
        formatUserGuessLabel()
        guessCount+=1
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining-=1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        
        let revealedWord = userGuessLabel.text!
        //Stop game after guesses
        if wrongGuessesRemaining == 0{
            playAgainButton.isHidden=false
            guessedLetterField.isEnabled=false
            guessLetterButton.isEnabled=false
            guessCountLabel.text="Out of Guesses"
        }else if !revealedWord.contains("_") {
            playAgainButton.isHidden=false
            guessedLetterField.isEnabled=false
            guessLetterButton.isEnabled=false
            guessCountLabel.text = "You Win!"
        }else{
            let guess = (guessCount==1 ? "guess": "guesses" )
            
            guessCountLabel.text="You've made \(guessCount) \(guess)"
            }
        
        
        
    }
    
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        guessLetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessLetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        createNewWord()
        playAgainButton.isHidden=true
        guessedLetterField.isEnabled=true
        guessLetterButton.isEnabled=false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining=maxGuesses
        lettersGuessed=""
        formatUserGuessLabel()
        guessCount=0
        guessCountLabel.text="You've made 0 guesses"
        
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        } else {
            guessLetterButton.isEnabled = false
        }
        
        
    }
    

    
    
}

