//
//  APIServiceTest.swift
//  BankinChallengeTests
//
//  Created by Alexandre Legros on 31/12/2021.
//

import XCTest
@testable import BankinChallenge

class APIServiceTest: XCTestCase {

    func testRequestBanksList() {
        let host = Host.production.rawValue
        let endpoint = Endpoints.listOfBanks.rawValue
        let request = URL(string: "\(host)\(endpoint)")
        XCTAssertEqual(request, URL(string: "https://api.bridgeapi.io/v2/banks"))
    }

}
