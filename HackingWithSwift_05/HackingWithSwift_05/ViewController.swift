//
//  ViewController.swift
//  HackingWithSwift_05
//
//  Created by Bárbara Tiefensee on 11/08/21.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private let reuseIdentifier = "cell"
    
    private var allWords = [String]()
    private var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector((startGame)))
        
        setup()
    }
    
    private func setup() {
        addTableView()
        loadingPath()
        startGame()
    }
}

//MARK: - Funcion
extension ViewController {
    private func loadingPath() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }
    
    @objc private func startGame() {
        title = allWords.randomElement()?.uppercased()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "submit", style: .default) { [weak self, weak alert] action in
            guard let answer = alert?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func submit(_ answers: String) {
        let lowerAnswer = answers.lowercased()
        let title = title?.lowercased()
        
        if lowerAnswer == title {
            showErrorMessage(title: "Word is the same", message: "You know, you can't do this")
        } else {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        
                        if lowerAnswer.count <= 3 {
                            if lowerAnswer.isEmpty {
                                showErrorMessage(title: "Empty", message: "The space is empty.")
                            } else {
                                showErrorMessage(title: "Less than 3", message: "The word must be greater than 3 characters.")
                            }
                        } else {
                            usedWords.insert(answers, at: 0)
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                        }
                    } else {
                        showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
                    }
                } else {
                    showErrorMessage(title: "Word used already", message: "Be more original!")
                }
            } else {
                guard let title = title?.uppercased() else { return}
                showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title).")
            }
        }
    }
    
    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        if misspelledRange.location == NSNotFound {
            return true
        } else {
            return false
        }
    }
    
    private func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Layout
extension ViewController {
    private func addTableView() {
        view.addSubview(tableView)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

//MARK: - Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        cell.setup(labelSetup: usedWords[indexPath.row])
        return cell
    }
}
