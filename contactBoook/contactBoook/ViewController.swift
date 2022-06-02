//
//  ViewController.swift
//  contactBoook
//
//  Created by Aigerim Abdurakhmanova on 02.06.2022.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    var contacts: [Contact] = [
        Contact.init(name: "Aigerim Abdurakhmanova", phoneNUmber: "87002223344", image: "contact.png"),
        Contact.init(name: "Galya Abdurakhmanova", phoneNUmber: "87013334456", image: "contact.png")
    ]
    
    override func viewDidLoad() {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        setupTableView()
        setUpNaviagtion()
    }
    
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "contactCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpNaviagtion() {
        navigationItem.title = "Contacts"
        self.navigationController?.view.backgroundColor = .white
//        self.navigationController?.navigationBar.backgroundColor = .clear
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addTapped))

    }
    
    @objc private func addTapped() {
//        let vc = UIViewController()
//        vc.view.backgroundColor = .white
//        navigationController?.pushViewController(vc, animated: true)
        let vc = AddContactViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactsTableViewCell
        
        cell.contact = contacts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}