//
//  ViewController.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import UIKit
import Network

class ViewController: UIViewController, listOfBanksDelegate {
    
    let apiService = APIService()
    var listOfBankRange = [Bank]()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var mainView: ListOfBanksView {self.view as! ListOfBanksView}
    
    override func loadView() {
        view = ListOfBanksView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        checkInternetConnectionDevice()
    }
    
    func callAPIForGetListOfBanks() {
        apiService.getListBank { response in
            DispatchQueue.main.async {
                switch response {
                    case .success(let itemsBank):
                        if !itemsBank.resources.isEmpty {
                            self.receiveListOfBanks(listOfBanks: itemsBank.resources)
                            self.mainView.uiLabelMessageLoadBanks.isHidden = true
                        } else {
                            self.checkListOfBankInUserDefault()
                        }
                    case .failure(let error):
                        self.checkListOfBankInUserDefault()
                        self.mainView.uiLabelMessageLoadBanks.text = error.localizedDescription
                }
                self.mainView.uiActivityIndicator.stopAnimating()
            }
        }
    }
    
    func receiveListOfBanks(listOfBanks: [DatasBanks]) {
        for item in listOfBanks {
            listOfBankRange.append(Bank(detailBank: item))
        }
        saveListOfBanksInUserDefault(listOfBanks: listOfBankRange)
        mainView.tableView.reloadData()
    }

    func saveListOfBanksInUserDefault(listOfBanks: [Bank]) {
        do {
            let listOfBanksEncoded = try JSONEncoder().encode(listOfBanks)
            UserDefaults.standard.set(listOfBanksEncoded, forKey: "listOfBanks")
        } catch {
            print("Une erreur s'est produite")
        }
    }
    
    func checkListOfBankInUserDefault() {
        if let savedListOfBanks = UserDefaults.standard.object(forKey: "listOfBanks") as? Data {
            showListOfBanksFromUserDefault(listOfBanksEncoded: savedListOfBanks)
        } else {
            noneListOfBanksFromUserDefault()
        }
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
    
    func showListOfBanksFromUserDefault(listOfBanksEncoded: Data) {
        do {
            self.listOfBankRange = try JSONDecoder().decode([Bank].self, from: listOfBanksEncoded)
            DispatchQueue.main.async {
                self.mainView.uiLabelMessageLoadBanks.isHidden = true
                self.mainView.uiActivityIndicator.stopAnimating()
            }
        } catch {
            DispatchQueue.main.async {
                self.mainView.uiActivityIndicator.stopAnimating()
                self.mainView.uiLabelMessageLoadBanks.text = "Une erreur s'est produite durant la récupération de la liste des banques."
            }
        }
    }
    
    func noneListOfBanksFromUserDefault() {
        DispatchQueue.main.async {
            self.mainView.uiActivityIndicator.stopAnimating()
            self.mainView.uiLabelMessageLoadBanks.text = "Aucune banque chargée.\nVeuillez vérifier votre connexion internet."
        }
    }
    
    func checkInternetConnectionDevice() {
        self.monitor.pathUpdateHandler = { pathUpdateHandler in
            pathUpdateHandler.status == .satisfied ? self.callAPIForGetListOfBanks() : self.checkListOfBankInUserDefault()
        }
        monitor.start(queue: queue)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    /*func numberOfSections(in tableView: UITableView) -> Int {
        return listOfBankRange.count
    }*/
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBankRange.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBank", for: indexPath) as! CellBank
        let item = listOfBankRange[indexPath.row]
        cell.selectionStyle = .none
        
        cell.uiLabelnameOfTheBank.text = item.nameOfBank
        cell.uiLabelnameOfTheBank.textColor = item.primaryColor != "" ?  UIColor(hex: item.primaryColor) : UIColor(hex: "#444444")
        
        if let logoURL = item.URLLogo {
            apiService.downloadImage(from: logoURL){ response  in
                if let data = response {
                    cell.uiImageLogo.isHidden = false
                    cell.uiImageLogo.image = UIImage(data: data)
                } else {
                    cell.uiImageLogo.isHidden = true
                }
            }
        } else {
            cell.uiImageLogo.isHidden = true
        }
        return cell
    }
}
