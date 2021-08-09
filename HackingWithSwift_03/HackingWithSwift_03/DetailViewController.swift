//
//  DetailViewController.swift
//  HackingWithSwift_03
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        view.backgroundColor = .white
        addImageView()
    }
    
    func setup(imageName: String) {
        detailImageView.image = UIImage(named: imageName)
        self.title = imageName
    }
    
    @objc func shareTapped() {
        guard let image = detailImageView.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true, completion: nil)
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
