//
//  DatasListBanksTest.swift
//  BankinChallengeTests
//
//  Created by Alexandre Legros on 31/12/2021.
//

import XCTest
@testable import BankinChallenge


class DatasListBanksTest: XCTestCase {
    
    let bank = DatasBanks(id: 504, name: "Ma French Bank", countryCode: "FR", primaryColor: nil, secondaryColor: nil, logoURL: Optional(""), authenticationType: Optional("WEBVIEW"), parentName: nil, capabilities: Optional(["ais"]), transfer: nil, payment: nil, channelType: Optional(["dsp2"]))
    
                         
    func testPropertiesDatasListBanks() {
        XCTAssertEqual(bank.id,504)
        XCTAssertEqual(bank.name, "Ma French Bank")
        XCTAssertEqual(bank.countryCode, "FR")
        XCTAssertEqual(bank.primaryColor , nil)
        XCTAssertEqual(bank.logoURL, "")
        XCTAssertEqual(bank.authenticationType, "WEBVIEW")
    }
}
