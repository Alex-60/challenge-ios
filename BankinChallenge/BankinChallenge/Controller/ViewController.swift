//
//  ViewController.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import UIKit
import Network

class ViewController: UIViewController {

    private var banksViewModel = BanksViewModel()
    private var userViewModel = UserViewModel()
    var mainView: ListOfBanksView {self.view as! ListOfBanksView}

    override func loadView() {
        view = ListOfBanksView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        
        self.userViewModel.receiveCountryCodeFromDevice()
        
        self.banksViewModel.banksLoaded = { [weak self] (datas, success) in
            DispatchQueue.main.async {
                self?.mainView.uiLabelMessageLoadBanks.isHidden = true
                self?.mainView.uiActivityIndicator.stopAnimating()
                if success {
                    self?.mainView.tableView.reloadData()
                } else {
                    self?.mainView.uiLabelMessageLoadBanks.isHidden = false
                    self?.mainView.uiLabelMessageLoadBanks.text = "Nous n'avons pas réussi à afficher la liste des banques."
                }
            }
        }
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.banksViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.banksViewModel.titleForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.banksViewModel.numberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBank", for: indexPath) as! CellBank
        let item = self.banksViewModel.listObjectBanks[indexPath.section].sectionObjects[indexPath.row]
        
        cell.selectionStyle = .none
        cell.createCellWithDataBank(datas: item)
    
        return cell
    }
    
}
