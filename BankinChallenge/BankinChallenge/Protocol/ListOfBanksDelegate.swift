//
//  ListOfBanksDelegate.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 23/12/2021.
//

import Foundation

protocol listOfBanksDelegate: AnyObject {
    func receiveListOfBanks(listOfBanks: [DatasBanks])
}
