//
//  ViewController.swift
//  HackingWithSwiff_02
//
//  Created by Bárbara Tiefensee on 06/08/21.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    private let buttonOne = UIButton()
    private let buttonTwo = UIButton()
    private let buttonThree = UIButton()
    
    private var countries = ["estonia", "france", "germany", "ireland", "italy",
                             "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    private var score = 0
    private var correctAnswer = 0
    private var titleAlert = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        setup()
        askQuestion()
    }
    
    private func setup() {
        addButtonOne()
        addButtonTwo()
        addButtonThree()
    }
}

//MARK: - Layout
extension ViewController {
    private func addButtonOne() {
        view.addSubview(buttonOne)
        
        
        buttonOne.layer.borderWidth = 1
        buttonOne.backgroundColor = .systemGray
        buttonOne.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonOne.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(250)
        }
        
        buttonOne.imageView?.snp.makeConstraints({ make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
        
    }
    
    private func addButtonTwo() {
        view.addSubview(buttonTwo)
        
        buttonTwo.tag = 1
        buttonTwo.layer.borderWidth = 1
        buttonTwo.backgroundColor = .systemGreen
        buttonTwo.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonTwo.snp.makeConstraints { make in
            make.top.equalTo(buttonOne.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(250)
        }
        
        buttonTwo.imageView?.snp.makeConstraints({ make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
    private func addButtonThree() {
        view.addSubview(buttonThree)
        
        buttonThree.tag = 2
        buttonThree.layer.borderWidth = 1
        buttonThree.backgroundColor = .systemRed
        buttonThree.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonThree.snp.makeConstraints { make in
            make.top.equalTo(buttonTwo.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(250)
        }
        
        buttonThree.imageView?.snp.makeConstraints({ make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
}

extension ViewController {
    private func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
    
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        self.title = countries[correctAnswer].uppercased()
    }
    
    @objc func buttonTapped(sender: UIButton) {
        
        if sender.tag == correctAnswer {
            titleAlert = "Correct"
            score += 1
        } else {
            titleAlert = "wrong"
            score -= 1
        }
        
        let alert = UIAlertController(title: titleAlert, message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: askQuestion))
        present(alert, animated: true, completion: nil)
    }
}

