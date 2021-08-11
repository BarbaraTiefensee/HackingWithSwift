//
//  TableViewController.swift
//  HackingWithSwift_04
//
//  Created by Bárbara Tiefensee on 11/08/21.
//
import SnapKit
import UIKit

class TableViewController: UIViewController {
    
    private let tableView = UITableView()
    private let webSites = ViewController()
    
    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Browser"
        navigationController?.navigationBar.prefersLargeTitles = true

        setup()
    }
    
    private func setup() {
        addTableView()
    }
}

extension TableViewController {
    private func addTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        webSites.websites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell()}
        cell.setup(labelCell: webSites.websites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = ViewController()
        view.webLoad = webSites.websites[indexPath.row]
        navigationController?.pushViewController(view, animated: true)
    }
    
}
