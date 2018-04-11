//
//  ViewController.swift
//  Layout
//
//  Created by Владислав Дашкевич on 10.04.2018.
//  Copyright © 2018 Владислав Дашкевич. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //private var cards = [UIView]()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomButton: UIButton!
    
    var previousTap = false
    var arrayStack = [UIStackView]()
    
    @IBAction func goTapped(_ sender: Any) {
        let numberOfCards = Int(textField.text ?? "0") ?? 0
        print(String(numberOfCards))
        
        if previousTap == true {
            for stack in arrayStack {
                stack.removeFromSuperview()
            }
        }
        addCards(numberOfCards)
        previousTap = true
        
        textField.text?.removeAll()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    private func addCards(_ count: Int) {
        guard netSize(items: count) > 0 else {
            return
        }
        var previousTopView: UIView? = nil
        
        var counterCard = count
        
        for _ in 1...netSize(items: count) {
            let stackView = UIStackView()
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.backgroundColor = UIColor.red
            stackView.spacing = 8
            stackView.axis = .horizontal
            if netSize(items: count) <= counterCard {
                addItemsTo(stack: stackView, count: netSize(items: count))
                counterCard -= netSize(items: count)
            }
            else
            {
                if counterCard != 0 {
                addItemsTo(stack: stackView, count: counterCard)
                counterCard = 0
                }
            }
            stackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stackView)
            
            if let prev = previousTopView {
                stackView.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 8).isActive = true
                stackView.heightAnchor.constraint(equalTo: prev.heightAnchor, multiplier: 1).isActive = true
            }
            else {
                stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24).isActive = true
            }
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
            
            previousTopView = stackView
            
            arrayStack.append(stackView)
        }
        
        previousTopView?.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -24).isActive = true
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    func addItemsTo(stack: UIStackView, count: Int) {
        for _ in 1...count {
            let view = UIView()
            view.backgroundColor = UIColor.orange
            stack.addArrangedSubview(view)
        }
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    private func netSize(items: Int) -> Int {
        var size = 0
        while items > size * size {
            size = size + 1
        }
        return size
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
