//
//  ProcessorTests.swift
//  SeaWorldTests
//
//  Created by Andrey Rodionov on 22/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import SeaWorld

class ProcessorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopulateEntitiesProportion() {
        let xCount = 8, yCount = 8
        let count = xCount * yCount
        let orcaPart = 0.05, penguinPart = 0.5

        let processor = Processor(worldXCount: xCount, worldYCount: yCount,
                                  orcaPart: orcaPart, penguinPart: penguinPart)

        let orcas = processor.world.cells.filter { $0.value is Orca }
        XCTAssertEqual(orcas.count, Int((Double(count) * orcaPart).rounded(.down)))

        let penguins = processor.world.cells.filter { $0.value is Penguin }
        XCTAssertEqual(penguins.count, Int((Double(count) * penguinPart).rounded(.down)))
    }

    func testPopulateRandom() {
        let xCount = 8, yCount = 8
        let orcaPart = 0.05, penguinPart = 0.5

        let processor1 = Processor(worldXCount: xCount, worldYCount: yCount,
                                   orcaPart: orcaPart, penguinPart: penguinPart)
        let processor2 = Processor(worldXCount: xCount, worldYCount: yCount,
                                   orcaPart: orcaPart, penguinPart: penguinPart)

    }
}
