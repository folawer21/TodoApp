import UIKit
import SwiftUI

final class CalendarView: UIViewController{
    var taskManager: TaskManager?
    private let tableView: UITableView = UITableView()
    private let containerView = UIView()
    private let bottomBorder = UIView()
    private let topBorder = UIView()
    private let containerCollectionView = UIView()
//    private let buttonHost = UIHostingController(rootView: PlusButton())
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private lazy var plusButton = {
        let plusButton = UIButton(type: .custom)
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        plusButton.layer.shadowOffset = .zero
        plusButton.layer.shadowRadius = 4
        plusButton.layer.shadowColor = UIColor.black.cgColor
        plusButton.layer.shadowOpacity = 0.4
        return plusButton
      }()
//    private let plusButton = PlusButton()
//    private var itemsArray: [String: [TodoItem]] = ["22.09":[TodoItem(text: "aaa", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil),TodoItem(text: "BBB", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil),
//                                                             TodoItem(text: "cccc", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil)],
//                                                    "25.11": [ TodoItem(text: "11111", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil),
//                                                    TodoItem(text: "11111", color: .gray, importance: .important, deadline: nil, isDone: false, createdAt: Date(), changedAt: nil)]]
    private var itemsArray: [String: [TodoItem]] = [:]
    private var dates: [String] = []
    
    private let collectionCellIdentifier = CalendarCollectionKitCell.reuseIdentifier
    private let tableCellIdentifier = CalendarTableKitCell.reuseIdentifier
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        print("isapperiang")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("didAppear")
    }
    

    private func loadData(){
        guard let datesArr = taskManager?.getDatesCollection(),
              let items = taskManager?.getCollectionByDate() else {return }
        dates = datesArr
        itemsArray = items
        print("result:", dates,itemsArray)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        containerCollectionView.backgroundColor = Colors.greyForBackground
        containerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = Colors.greyForBackground
//        containerView.backgroundColor = .red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        containerCollectionView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        tableView.backgroundColor = Colors.greyForBackground
        tableView.layer.cornerRadius = 15
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0
        tableView.allowsSelection = false

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = Colors.greyForBackground
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder.backgroundColor = .gray
        topBorder.backgroundColor = .gray
//        buttonHost.view.backgroundColor = .clear
                
        addSubViews()
        removeAutoresizeMask()
        applyConstraints()
        
        tableView.register(CalendarTableKitCell.self, forCellReuseIdentifier: tableCellIdentifier)
        tableView.register(HeaderViewKit.self, forHeaderFooterViewReuseIdentifier: HeaderViewKit.reuseIdentifier)
        collectionView.register(CalendarCollectionKitCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        loadData()
//        print("result:", dates)
    
    }
    
    private func addSubViews(){
//        view.addSubview(collectionView)
//        view.addSubview(tableView)
        view.addSubview(containerView)
        view.addSubview(containerCollectionView)
        containerView.addSubview(tableView)
        containerView.addSubview(plusButton)
        
        containerCollectionView.addSubview(collectionView)
        
        containerCollectionView.addSubview(topBorder)
        containerCollectionView.addSubview(bottomBorder)
        
        
//        buttonHost.willMove(toParent: self)
//        addChild(buttonHost)
//        containerView.addSubview(buttonHost.view)
//        buttonHost.didMove(toParent: self)
//        view.addSubview(plusButton)
    }
    
    private func removeAutoresizeMask(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        buttonHost.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 50),
            containerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.topAnchor.constraint(equalTo: containerCollectionView.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerCollectionView.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerCollectionView.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerCollectionView.layoutMarginsGuide.bottomAnchor),
            
            topBorder.topAnchor.constraint(equalTo: containerCollectionView.topAnchor),
            topBorder.leadingAnchor.constraint(equalTo: containerCollectionView.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: containerCollectionView.trailingAnchor),
            topBorder.heightAnchor.constraint(equalToConstant: 0.5),
            
            bottomBorder.topAnchor.constraint(equalTo: containerCollectionView.bottomAnchor, constant: -0.5),
            bottomBorder.leadingAnchor.constraint(equalTo: containerCollectionView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: containerCollectionView.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.5),
            
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor)
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: containerCollectionView.bottomAnchor),
            
            
            plusButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            plusButton.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: -20),
//            plusButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    @objc private func didTapPlusButton() {
        guard let taskManager = taskManager else {return }
        let todoProd = TodoProduction(taskManager: taskManager, delegate: self, toggleOn: false, deadline: Calendar.current.date(
              byAdding: .day,
              value: 1,
              to: Date()) ?? Date(),
              selectedBrightness: 1.0,
              selectedColor: .blue,
              selectedCategory: .red
        )
        let hostingController = UIHostingController(rootView: todoProd)
        self.present(hostingController,animated: true)
       
//        show(hostingController, sender: self)
        }
}

//UITableView
extension CalendarView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as? CalendarTableKitCell else {return UITableViewCell()}
        
        let date = dates[indexPath.section]
        guard let items = itemsArray[date] else {return UITableViewCell()}
        let item = items[indexPath.row]
        cell.backgroundColor = Colors.greyForBackground
        cell.label.text = item.text
        cell.layer.masksToBounds = true
        cell.contentView.layer.masksToBounds = true
        if indexPath.row == 0 {
            if items.count == 1 {
                cell.contentView.layer.cornerRadius = 15

            }else{
                cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.contentView.layer.cornerRadius = 15
            }
            
        }else if indexPath.row == (items.count - 1) {
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.contentView.layer.cornerRadius = 15
        }else{
        }
        if item.isDone{
            cell.completeTask()
        }
        
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        dates[section]
//    }
//    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let date = dates[section]
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderViewKit.reuseIdentifier) as? HeaderViewKit else{
            return HeaderViewKit()
        }
        headerView.setup(text: date)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "Done"){ [weak self] (action,view,completionHandler) in
            self?.markAsDone(indexPath: indexPath)
        }
        done.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unDone = UIContextualAction(style: .normal, title: "Undone"){ [weak self] (action,view,completionHandler) in
            self?.markIsUnDone(indexPath: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [unDone])
    }
    private func markAsDone(indexPath: IndexPath){
        guard let item = tableView.cellForRow(at:indexPath) as? CalendarTableKitCell else {return}
        item.completeTask()
        let date = dates[indexPath.section]
        guard let todoArray = itemsArray[date] else {return}
        let todo = todoArray[indexPath.row]
        taskManager?.makeComplete(id: todo.id, complete: true)
              
        
    }
    
    private func markIsUnDone(indexPath: IndexPath){
        guard let item = tableView.cellForRow(at: indexPath) as? CalendarTableKitCell else {return}
        item.unCompleteTask()
        let date = dates[indexPath.section]
        guard let todoArray = itemsArray[date] else {return}
        let todo = todoArray[indexPath.row]
        taskManager?.makeComplete(id: todo.id, complete: false)
    }
}


extension CalendarView: UITableViewDelegate{
    
}

//UICollectionView

extension CalendarView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as? CalendarCollectionKitCell else {return UICollectionViewCell()}
        var text = dates[indexPath.row]
        if indexPath.row == 0 && indexPath.section == 0{
            cell.layer.cornerRadius = 15
            cell.layer.borderColor = Colors.darkGrey.cgColor
            cell.layer.borderWidth = 1.5
            cell.backgroundColor = Colors.lightGrey
            cell.isSelected = true
        }
        text.replace(" ", with: "\n")
        cell.dateLabel.text = text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dates.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath)
        item?.layer.cornerRadius = 15
        item?.layer.borderColor = Colors.darkGrey.cgColor
        item?.layer.borderWidth = 1.5
        item?.backgroundColor = Colors.lightGrey
        let date = dates[indexPath.item]
        if let section = dates.firstIndex(of: date){
            let indexPath = IndexPath(row: 0, section: section)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath)
        item?.layer.cornerRadius = 0
        item?.layer.borderColor = .none
        item?.layer.borderWidth = 0
        item?.backgroundColor = .clear
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let visibleSections = tableView.indexPathsForVisibleRows?.map { $0.section } ?? []
            if let firstVisibleSection = visibleSections.first {
                let indexPath = IndexPath(item: firstVisibleSection, section: 0)
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
 
  
}

extension CalendarView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}


extension CalendarView: TodoProductionDelegate{
    func screenWasClosen() {
        loadData()
        tableView.reloadData()
        collectionView.reloadData()
    }
}
