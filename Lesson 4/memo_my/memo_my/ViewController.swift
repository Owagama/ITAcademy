//
//  ViewController.swift
//  memo_my
//
//  Created by Владислав Дашкевич on 03.04.2018.
//  Copyright © 2018 Владислав Дашкевич. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countTap = 0
    var countTitle = 0
    var firstTap: Int?
    var wrongColor: Int?
    let backgroundColor = UIColor.blue
    
    @IBOutlet var cards: [UIButton]!
    @IBOutlet var tapToStart: UIButton!
    
    let arrayImagine = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊"]
    let arraySystemWords = ["Tap to Start!", "Tap to begin", "Lets play", "You are win!"]
    
    override func viewDidLoad() {
        for card in cards {
            card.isEnabled = false
            card.backgroundColor = UIColor.blue
            card.setTitle("", for: .normal)
            tapToStart.setTitle(arraySystemWords[0], for: .normal)
        }
    }
    @IBAction func cardAction(_ sender: UIButton) {
        sender.setTitleColor(UIColor.black, for: .normal)
        if  firstTap != nil && cards[firstTap!].backgroundColor == UIColor.red{
            incaps(cards[firstTap!], cards[wrongColor!],backgroundColor: backgroundColor, titleColor: UIColor.clear)
            firstTap = nil
            
        }
        if firstTap != nil {
            if cards[firstTap!].currentTitle == sender.currentTitle && firstTap! != cards.index(of: sender){
                cards[firstTap!].isEnabled = false
                sender.isEnabled = false
                incaps(cards[firstTap!], sender, backgroundColor: UIColor.green, titleColor: UIColor.black)
                firstTap = nil
                countTitle += 1
                if countTitle == arrayImagine.count / 2 {
                    tapToStart.setTitle(arraySystemWords[3], for: .normal)
                    tapToStart.isEnabled = true
                    countTitle = 0

                }
                
            } else {
                wrongColor = cards.index(of: sender)
                cards[firstTap!].backgroundColor = UIColor.red
                sender.backgroundColor = UIColor.red
            }
        } else {
            firstTap = cards.index(of: sender)
        }
    }

    /////////////////////////// TapButton ///////////////////////////
    @IBAction func tapAction(_ sender: UIButton) {
        if countTap == 0 {
            tapToStart.setTitle(arraySystemWords[1], for: .normal)
            var arrayRandom: [String] = arrayTitle(arrayImagine)
            for (i, card) in cards.enumerated() {
                card.setTitle(arrayRandom[i], for: .normal)
            }
        }
        
        if countTap == 1 {
            tapToStart.setTitle(arraySystemWords[2], for: .normal)
            for card in cards {
                card.setTitleColor(UIColor.clear, for: .normal)
                card.isEnabled = true
            }
            tapToStart.isEnabled = false
        }
        
        countTap += 1
        
        if tapToStart.currentTitle == arraySystemWords[3]{
            countTap = 0
            viewDidLoad()
        }
    }
///////////////////////////Happy BirthDay!///////////////////////////////////////////////////

   
    //////////////////////////Func from random///////////////////////////////////////////////////
    func arrayTitle(_ array: [String]) -> [String] {
        var funcArray = array
        var randArray = [String]()
        var index = funcArray.count
        while 0 < index {
            randArray.append(funcArray.remove(at: Int(arc4random_uniform(_: UInt32(index)))))
            index -= 1
        }
        return randArray
    }
    
//////////////////////////Func without copy-paste///////////////////////////////////////////////////
    func incaps(_ first: UIButton,_ second: UIButton, backgroundColor colorBack: UIColor, titleColor colorTitle: UIColor ) {
        first.setTitleColor(colorTitle, for: .normal)
        second.setTitleColor(colorTitle, for: .normal)
        first.backgroundColor = colorBack
        second.backgroundColor = colorBack
    }
}








