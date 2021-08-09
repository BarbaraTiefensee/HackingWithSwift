//
//  DetailViewController.swift
//  HackingWithSwift_01
//
//  Created by Bárbara Tiefensee on 07/08/21.
//
import SnapKit
import UIKit

class DetailViewController: UIViewController {
    
    private let detailImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        addImageView()
    }
    
    func setup(imageName: String) {
        detailImageView.image = UIImage(named: imageName)
        self.title = imageName
    }
}

//MARK: -Layout
extension DetailViewController {
    private func addImageView() {
        view.addSubview(detailImageView)
    
        detailImageView.contentMode = .scaleAspectFit
        
        detailImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
