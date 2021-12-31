//
//  DatasListBanks.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import Foundation

struct DatasListBanks: Codable {
    let resources: [DatasBanks]
    let pagination: DatasPagination?
}

struct DatasBanks: Codable {
    let id: Int
    let name: String
    let countryCode: String
    let primaryColor: String?
    let secondaryColor: String?
    let logoURL: String?
    let authenticationType: String?
    let parentName: String?
    let capabilities: [String]?
    let transfer: DatasTransfer?
    let payment: DatasPayment?
    let channelType: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case countryCode = "country_code"
        case primaryColor = "primary_color"
        case secondaryColor = "secondary_color"
        case logoURL = "logo_url"
        case authenticationType = "authentication_type"
        case parentName = "parent_name"
        case capabilities, transfer, payment
        case channelType = "channel_type"
    }
}

struct DatasTransfer: Codable {
    let nbMaxTransactions: Int?
    let maxSizeLabel: Int?
    
    enum CodingKeys: String, CodingKey {
        case nbMaxTransactions = "nb_max_transactions"
        case maxSizeLabel = "max_size_label"
    }
}

struct DatasPayment: Codable {
    let nbMaxTransactions: Int?
    let maxSizeLabel: Int?
    
    enum CodingKeys: String, CodingKey {
        case nbMaxTransactions = "nb_max_transactions"
        case maxSizeLabel = "max_size_label"
    }
}

struct DatasPagination: Codable {
    let nextURI: String?
    
    enum CodingKeys: String, CodingKey {
        case nextURI = "next_uri"
    }
}
