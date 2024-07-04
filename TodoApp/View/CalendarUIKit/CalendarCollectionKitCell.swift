//
//  CalendarCollectionCell.swift
//  test
//
//  Created by Александр  Сухинин on 03.07.2024.
//

import UIKit

final class CalendarCollectionKitCell: UICollectionViewCell{
    
    static let reuseIdentifier = "DateCell"
      
      let dateLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.textAlignment = .center
          label.numberOfLines = 0
          return label
      }()
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          contentView.addSubview(dateLabel)
          NSLayoutConstraint.activate([
              dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
              dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
          ])
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    override func prepareForReuse() {
        self.layer.cornerRadius = 0
        self.layer.borderColor = .none
        self.layer.borderWidth = 0
        self.backgroundColor = .clear
    }
}

