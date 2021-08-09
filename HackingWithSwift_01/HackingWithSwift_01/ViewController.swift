//
//  ViewController.swift
//  HackingWithSwift_01
//
//  Created by Bárbara Tiefensee on 06/08/21.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    private let rouseIdentifier = "Pictures"
    private var pictures = [String]()
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        fileManager()
        addTableView()
    }
    
    private func fileManager() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
}

//MARK: - Layout
extension ViewController {
    private func addTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: rouseIdentifier)
        
        tableView.backgroundColor = .white
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rouseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.setup(labelSetup: pictures[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.setup(imageName: pictures[indexPath.row])
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
