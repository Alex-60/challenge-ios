//
//  ListOfBanksView.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import UIKit

class ListOfBanksView: UIView {

    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(CellBank.self, forCellReuseIdentifier: "cellBank")
        tableview.backgroundColor = .white
        tableview.layer.cornerRadius = 20
        tableview.separatorInset.left = 20
        tableview.separatorInset.right = 20
        return tableview
    }()
    
    let uiLabelMessageLoadBanks: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chargement des banques..."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray2
        return label
    }()
    
    let uiActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .gray
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        backgroundColor = .systemGray6
        addSubview(tableView)
        addSubview(uiLabelMessageLoadBanks)
        addSubview(uiActivityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            uiLabelMessageLoadBanks.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            uiLabelMessageLoadBanks.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
            uiLabelMessageLoadBanks.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            uiLabelMessageLoadBanks.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            
            uiActivityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 30),
            uiActivityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
        ])
    }

}
