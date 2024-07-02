//
//  TodoCalendarView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 03.07.2024.
//

import UIKit

final class TodoCalendarView: UIViewController{
    private let tableView: UITableView = UITableView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
//    private let plusButton = PlusButton()
    private var itemsArray: [String: [TodoItem]] = ["22.09":[TodoItem(text: "aaa", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil),TodoItem(text: "BBB", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil),
                                                             TodoItem(text: "cccc", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil)],
                                                    "25.11": [ TodoItem(text: "11111", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil),
                                                    TodoItem(text: "11111", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil)]]
    private var dates: [String] = ["22.09","24.10","24.11","25.11"]
    
    private let collectionCellIdentifier = CalendarCollectionCell.reuseIndentifier
    private let tableCellIdentifier = TodoCalendarCell.reuseIdentifier
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
                
        addSubViews()
        removeAutoresizeMask()
        applyConstraints()
        
        tableView.register(TodoCalendarCell.self, forCellReuseIdentifier: tableCellIdentifier)
        collectionView.register(CalendarCollectionCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
    }
    
    private func addSubViews(){
        view.addSubview(collectionView)
        view.addSubview(tableView)
//        view.addSubview(plusButton)
    }
    
    private func removeAutoresizeMask(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
}

//UITableView
extension TodoCalendarView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as? TodoCalendarCell else {return UITableViewCell()}

        let date = dates[indexPath.section]
        guard let items = itemsArray[date] else {return UITableViewCell()}
        
        let cellText = items[indexPath.row].text
        cell.label.text = cellText
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dates[section]
        guard let items = itemsArray[date] else {return 0}
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
}

extension TodoCalendarView: UITableViewDelegate{
    
}

//UICollectionView

extension TodoCalendarView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as? CalendarCollectionCell else {return UICollectionViewCell()}
        
        cell.label.text = dates[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dates.count
    }
}

extension TodoCalendarView: UICollectionViewDelegateFlowLayout{
    
}
