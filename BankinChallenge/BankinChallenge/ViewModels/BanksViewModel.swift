//
//  BanksViewModel.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import Foundation
import Network

class BanksViewModel: NSObject {
    
    private let apiService = APIService()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")

    var banksLoaded: (([ObjectsBank]?, Bool) -> Void)?
    var listObjectBanks = [ObjectsBank]()
    
    override init() {
        super .init()
        checkInternetConnectionForDevice()
    }
    
    private func checkInternetConnectionForDevice() {
        self.monitor.pathUpdateHandler = { pathUpdateHandler in
            pathUpdateHandler.status == .satisfied ? self.callAPIForGetListOfBanks() : self.checkListOfBankInUserDefault()
        }
        monitor.start(queue: queue)
    }
    
    func handleResponse(response: [ObjectsBank]?, success: Bool) {
        if let banksLoaded = self.banksLoaded {
            banksLoaded(response, success)
        }
    }
    
    private func callAPIForGetListOfBanks() {
        apiService.getListBank { response in
            switch response {
                case .success(let itemsBank):
                    let detailBanks = self.extractDatasBanksByBank(datasBanks: itemsBank)
                    if let banks = detailBanks {
                        self.saveListOfBanksInUserDefault(listOfBanks: banks)
                    }
                self.handleResponse(response: detailBanks, success: true)
                case .failure(let error):
                    print("Error : \(error.rawValue)")
                    self.handleResponse(response: nil, success: false)
            }
        }
    }

    private func checkListOfBankInUserDefault() {
        if let savedListOfBanks = UserDefaults.standard.object(forKey: "listOfBanks") as? Data {
            receiveListOfBanksFromUserDefault(listOfBanksEncoded: savedListOfBanks)
        } else {
            handleResponse(response: nil, success: false)
        }
    }
    
    private func receiveListOfBanksFromUserDefault(listOfBanksEncoded: Data) {
        do {
            self.listObjectBanks = try JSONDecoder().decode([ObjectsBank].self, from: listOfBanksEncoded)
            self.handleResponse(response: self.listObjectBanks, success: true)
        } catch {
            handleResponse(response: nil, success: false)
        }
    }
    
    private func saveListOfBanksInUserDefault(listOfBanks: [ObjectsBank]) {
        do {
            let listOfBanksEncoded = try JSONEncoder().encode(listOfBanks)
            UserDefaults.standard.set(listOfBanksEncoded, forKey: "listOfBanks")
        } catch {
            print("Une erreur s'est produite")
        }
    }
    
    private func extractDatasBanksByBank(datasBanks: DatasListBanks?) -> [ObjectsBank]? {
        if let infos = datasBanks {
            let listOfBanksRange: [String:[DatasBanks]] = Dictionary(grouping: infos.resources, by: { $0.countryCode })
            for (key,value) in listOfBanksRange {
                listObjectBanks.append(ObjectsBank(sectionName: key, sectionObjects: value))
            }
            return listObjectBanks
        }
        return nil
    }
    
    func numberOfSection() -> Int {
        return self.listObjectBanks.count
    }
    
    func titleForSection(section: Int) -> String? {
        return listObjectBanks[section].sectionName
    }
    
    func numberOfRows(section: Int) -> Int {
        return self.listObjectBanks[section].sectionObjects.count
    }
    
}
