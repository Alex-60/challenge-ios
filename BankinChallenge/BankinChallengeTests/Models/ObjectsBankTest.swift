//
//  ObjectsBankTest.swift
//  BankinChallengeTests
//
//  Created by Alexandre Legros on 31/12/2021.
//

import XCTest
@testable import BankinChallenge

class ObjectsBankTest: XCTestCase {
    
    let objectBank = ObjectsBank(sectionName: "GB", sectionObjects: [DatasBanks(id: 473, name: "Barclays UK Premier (PINsentry Card Reader)", countryCode: "GB", primaryColor: nil, secondaryColor: nil, logoURL: Optional("https://web.bankin.com/img/banks-logo/uk/05_barclays@2x.png"), authenticationType: Optional("INTERNAL_CREDS"), parentName: Optional("Barclays UK"), capabilities: Optional(["ais"]), transfer: nil, payment: nil, channelType: Optional(["direct_access"]))])
    
    func testPropertiesObjectBank() {
        XCTAssertEqual(objectBank.sectionName, "GB")
        XCTAssertEqual(objectBank.sectionObjects[0].id, 473)
        XCTAssertEqual(objectBank.sectionObjects[0].name, "Barclays UK Premier (PINsentry Card Reader)")
        XCTAssertEqual(objectBank.sectionObjects[0].countryCode, "GB")
        XCTAssertEqual(objectBank.sectionObjects[0].primaryColor, nil)
        XCTAssertEqual(objectBank.sectionObjects[0].authenticationType, Optional("INTERNAL_CREDS"))
    }
}
