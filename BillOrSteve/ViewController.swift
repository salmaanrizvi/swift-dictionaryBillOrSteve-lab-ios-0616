//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var facts = [String : [String]]()
    var totalRandomFacts : Int = 0
    var totalAnsweredCorrectly : Int = 0
    var totalFactsDisplayed : Int = 0
    var currentFactAnswer : String = ""
    @IBOutlet var numberCorrectLabel: UILabel!
    @IBOutlet var randomFactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFacts()

        for factArray in facts.values { totalRandomFacts += factArray.count }
        
        numberCorrectLabel.text = "\(totalAnsweredCorrectly) / \(totalFactsDisplayed)"
        
        generateFacts()

    }
    
    @IBAction func answerTapped(sender: UIButton) {
        if let title = sender.titleLabel?.text {
            if title == "steve" && currentFactAnswer == "Steve Jobs" { // player answered Steve Jobs
                print("Steve is correct!")
                totalAnsweredCorrectly += 1
            }
            else if title == "bill" && currentFactAnswer == "Bill Gates" {
                print("Bill is correct!")
                totalAnsweredCorrectly += 1
            }
        }
        
        numberCorrectLabel.text = "\(totalAnsweredCorrectly) / \(totalFactsDisplayed)"
        
        generateFacts()
    }

    func generateFacts() {
        
        if totalFactsDisplayed == totalRandomFacts { randomFactLabel.text = "Game over!" }
        else {
            if let randomFact = getRandomFact() {
                randomFactLabel.text = randomFact.1
                if let index = facts[randomFact.0]?.indexOf(randomFact.1) {
                    facts[randomFact.0]?.removeAtIndex(index)
                    totalFactsDisplayed += 1
                    currentFactAnswer = randomFact.0
                }
            }
        }
    }
    
    func getRandomFact() -> (String, String)? {
        let randPerson : String = randomPerson()
        
        print("Getting Random Fact for: \(randPerson)")
        
        if let randomFactsArray = facts[randPerson] {
            if randomFactsArray.isEmpty {
                print("No more facts for \(randPerson). Trying again.")
                return getRandomFact()
            } else {
                let generatedRandomFactNumber = randomNumberFromZeroTo(randomFactsArray.count)
                return (randPerson, randomFactsArray[generatedRandomFactNumber])
            }
        } else {
            return nil
        }
    }
    
    func createFacts() {
        facts["Steve Jobs"] =
            ["He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
             "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
             "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
             "He was a pescetarian, meaning he ate no meat except for fish."]
        
        facts["Bill Gates"] =
            ["He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
                "He scored 1590 (out of 1600) on his SATs.",
                "His foundation spends more on global health each year than the United Nation's World Health Organization.",
                "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
                "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
    }
    
    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
}
