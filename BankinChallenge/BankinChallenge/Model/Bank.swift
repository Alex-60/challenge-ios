//
//  Bank.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import Foundation

struct Bank: Codable {
    
    var detailBank: DatasBanks
    
    var nameOfBank: String {
        detailBank.name
    }
    
    var primaryColor: String {
        detailBank.primaryColor ?? ""
    }
    
    var URLLogo: URL? {
        URL(string: detailBank.logoURL ?? "")
    }
    
}
