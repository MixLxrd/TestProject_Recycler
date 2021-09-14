//
//  DetailViewController.swift
//  TestProject_RecyclerHH
//
//  Created by Mike on 08.09.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var ID: Int = 0
    var parentID: Int = 0
    
    var areas: Areas = [] {
        didSet {
            areasTableView.reloadData()
        }
    }
    
    private lazy var areasTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.register(AreaTableViewCell.self, forCellReuseIdentifier: String(describing: AreaTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    init(id: Int, parentID: Int, areas: Areas, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.ID = id
        self.parentID = parentID
        self.areas = areas
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailViewController {
    private func setupLayout() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(areasTableView)
        let constraints = [
            areasTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            areasTableView.topAnchor.constraint(equalTo: view.topAnchor),
            areasTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            areasTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas[ID].areas[parentID].areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AreaTableViewCell.self), for: indexPath) as! AreaTableViewCell
        cell.textLabel?.text = areas[ID].areas[parentID].areas[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            areas[ID].areas[parentID].areas.remove(at: indexPath.row)
            
        } else if editingStyle == .insert {
            
        }
    }
}
