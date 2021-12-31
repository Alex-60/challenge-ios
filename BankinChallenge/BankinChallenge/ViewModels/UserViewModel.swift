//
//  UserViewModel.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 31/12/2021.
//

import Foundation

class UserViewModel: NSObject {

    override init() {
        super .init()
        receiveCountryCodeFromDevice()
    }
    
    func receiveCountryCodeFromDevice() {
        let countryCodeUser = NSLocale.current.regionCode
        if let currentUserCountryCode = countryCodeUser {
            UserDefaults.standard.set(currentUserCountryCode, forKey: "currentUserCountryCode")
        }
    }
}
