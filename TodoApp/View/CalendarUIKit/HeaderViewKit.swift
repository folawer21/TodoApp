//
//  HeaderView.swift
//  test
//
//  Created by Александр  Сухинин on 03.07.2024.
//

import UIKit

final class HeaderViewKit: UITableViewHeaderFooterView {
    static let reuseIdentifier = "headerView"
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Colors.greyForBackground
    }
    func setup(text: String) {
        addSubview(label)
        label.text = text
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(text: "")
    }
}
