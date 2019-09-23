//
//  SeaWorldTests.swift
//  SeaWorldTests
//
//  Created by Andrey Rodionov on 11/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import SeaWorld

class SeaWorldTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNeighboorCells() {
        let world = World(xCount: 8, yCount: 8, cells: WorldCells())

        let testData = [
            (for: 0, neighbors: [1, 8, 9, 7, 15, 63, 56, 57]),   // top + left
            (for: 12, neighbors: [3, 4, 5, 11, 13, 19, 20, 21]),  // center
            (for: 63, neighbors: [62, 54, 55, 48, 56, 6, 7, 0])   // bottom + right
        ]

        testData.forEach { testData in
            XCTAssertEqual(testData.neighbors.sorted(), world.neighborCells(testData.for).sorted())
        }
    }
}
