//
//  ViewController.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var values: MainResponse?
    private var employees: [Employee] = []
    private var companyName: String = ""
    
    private var tableView = UITableView()
    private var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        safeArea = view.layoutMarginsGuide
        
        fetchData()
        setupTableView()
    }
    
    // MARK: Create TableView + TableViewCell
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 90
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        
        setupTableViewCell()
    }
    
    func setupTableViewCell() {
        tableView.register(UINib(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    // MARK: TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MainTableCell else {
            fatalError("Unable to dequeue Cell")
        }
        cell.nameLabel.text = self.employees[indexPath.row].name
        cell.phoneLabel.text = self.employees[indexPath.row].phoneNumber
        cell.skillsLabel.text? = ""
        for skill in self.employees[indexPath.row].skills! {
            cell.skillsLabel.text?.append("\(skill),  ")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.companyName
    }
    
    // MARK: Networking
    
    func fetchData() {
        APICaller.shared.requestJSON() { result in
            switch result {
            case .success(let model):
                guard let employ = model.company.employees, let tempCompany = model.company.name else {
                    return
                }
                self.companyName = tempCompany
                self.employees = employ
                self.employees.sort { $0.name!.lowercased() < $1.name!.lowercased() }
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    
}
