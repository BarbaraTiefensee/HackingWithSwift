//
//  TableViewCell.swift
//  HackingWithSwift_05
//
//  Created by Bárbara Tiefensee on 12/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(labelSetup: String) {
        label.text = labelSetup
    }
}

extension TableViewCell {
    
    private func addLabel() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
