//
//  TodoCalendarCell.swift
//  test
//
//  Created by Александр  Сухинин on 03.07.2024.
//

import UIKit

final class CalendarTableKitCell: UITableViewCell {
    static let reuseIdentifier = "calendarCell"
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
        }()
    let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func completeTask() {
        label.textColor = .gray
        label.strikeThrough(true)
    }
    func unCompleteTask() {
        label.textColor = .black
        label.strikeThrough(false)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(circleView)
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            circleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            circleView.widthAnchor.constraint(equalToConstant: 25),
            circleView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        contentView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        contentView.layer.cornerRadius = 0
        circleView.tintColor = .clear
        unCompleteTask()
    }
}
