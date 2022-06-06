//
//  ViewController.swift
//  contactBoook
//
//  Created by Aigerim Abdurakhmanova on 02.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var contacts: [Contact] = [] {
        didSet{
            tableView.reloadData()
            if contacts.count == 0 {label.isHidden = false}
            else {label.isHidden = true}
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Contacts"
        return label
    }()
    
    private let tableView = UITableView()
    private var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.loadView()
        contacts.append(Contact.init(name: "Aigerim Abdurakhmanova", phoneNumber: "87002223344", gender: "female"))
        safeArea = view.layoutMarginsGuide
        setupTableView()
        setUpNavigation()
        
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func setupTableView() {
        
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
    
    private func setUpNavigation() {
        navigationItem.title = "Contacts"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        let vc = AddContactViewController()
        vc.delegate = self
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ContactDetailsViewController()
        vc.contact = contacts[indexPath.row]
        vc.index = indexPath.row
        vc.editDelegate = self
        vc.deleteDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: AddContactDelegate, SendEdittedContact {
    
    func addContact(contact: Contact) {
        self.contacts.append(contact)
    }

    func sendEdittedContact(row: Int, contact: Contact) {
        self.contacts[row] = contact
    }
    
    func deleteContact(index: Int) {
        self.contacts.remove(at: index)
    }
}

