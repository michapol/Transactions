//
//  TransactionsTests.swift
//  TransactionsTests
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import XCTest
@testable import Transactions

class TransactionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownloader() {
        let (testFileURL,fileData) = testData()
        
        let downloader = DataDownloader()
        downloader.download(url: testFileURL) { (data) in
            if let data = data {
                XCTAssert(data == fileData)
            } else {
                XCTFail("No Data!")
            }
        }
    }
    
    func testTransactionDecoder() {
        let (_, testFileData) = testData()
        
        let decoder = TransactionDecoder()
        guard let transactions = decoder.decode(data: testFileData) else {
            XCTFail("No Data!")
            return
        }
        XCTAssert(transactions.data.count == 3)
    }
    
    func testCurrencyFormatter() {
        let testData: [CurrencyTest] = [
            CurrencyTest(value: 2, currency: "GBP", result: "£2.00"),
            CurrencyTest(value: 15.5, currency: "USD", result: "$15.50"),
            CurrencyTest(value: 36, currency: "CNY", result: "CN¥36.00")
        ]
        let currencyFormatter = CurrencyFormatter()
        
        let results: [String] = testData.map({ currencyFormatter.format(value: $0.value, as: $0.currency) })
        
        XCTAssert(results == testData.map({ $0.result }))
    }
    
    func testData() -> (URL, Data) {
        let testBundle = Bundle(for: type(of: self))
        guard
            let testFileURL = testBundle.url(forResource: "TestTransactions", withExtension: "json"),
            let testFileData = try? Data(contentsOf: testFileURL, options: .uncached)
        else { fatalError("Unable to locate or load test file")}
        return (testFileURL, testFileData)
    }

    struct CurrencyTest {
        let value: Double
        let currency: String
        let result: String
    }

}
