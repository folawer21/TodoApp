//
//  TodoCalendarCell.swift
//  test
//
//  Created by Александр  Сухинин on 03.07.2024.
//

import UIKit

final class CalendarTableKitCell: UITableViewCell{
    
    static let reuseIdentifier = "calendarCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
        
        }()
        
    func completeTask(){
        label.textColor = .gray
//        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: label.text ?? "")
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
//        print(label.attributedText)
//        label.attributedText = attributeString
        label.strikeThrough(true)
        
    }
    
    func unCompleteTask(){
        label.textColor = .black
        label.strikeThrough(false)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner,.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 0
        unCompleteTask()
    }
    
}
