//
//  MainViewController.swift
//  TestProject_Recycler
//
//  Created by Mike on 07.09.2021.
//

import UIKit
import CoreData


class MainViewController: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    
    var areas: Areas? {
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
        networkDataFetcher.fetchAreas { response in
            guard let search = response else { return }
            self.areas = search
        }
        
    }
    
}

extension MainViewController {
    private func setupLayout() {
        title = "Areas"
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return areas?[section].areas.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AreaTableViewCell.self), for: indexPath) as! AreaTableViewCell
            cell.textLabel?.text = areas?[indexPath.section].areas[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController(id: indexPath.section, parentID: indexPath.row, areas: areas!, title: (areas?[indexPath.section].areas[indexPath.row].name)!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return areas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return areas?[section].name ?? ""
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            areas?[indexPath.section].areas.remove(at: indexPath.row)
            
        } else if editingStyle == .insert {
            
        }
    }
    
}
