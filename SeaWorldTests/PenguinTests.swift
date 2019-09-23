//
//  PenguinTests.swift
//  SeaWorldTests
//
//  Created by Andrey Rodionov on 22/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import SeaWorld

class PenguinTests: XCTestCase {

    func testPopulateEntitiesProportion() {
        var world = World(xCount: 3, yCount: 3, cells: WorldCells())
        let testPenguin = Penguin()
        world.cells = ([1 : Orca(), 2 : Penguin(), 3 : Orca(),
                        4 : nil, 5: testPenguin, 6 : Penguin(),
                        7 : Orca(), 8 : Orca()])
        let availableCells = world.availableCells(forAnimalAt: 5)

        // 1st turn
        var changedCells = testPenguin.turn(curr: 5, available: availableCells)
        XCTAssertTrue(changedCells[5] == nil)
        XCTAssertTrue(changedCells[4] is Penguin)

        // 2nd turn
        changedCells = testPenguin.turn(curr: 5,
                                        available: changedCells)
        XCTAssertTrue(changedCells[4] == nil)
        XCTAssertTrue(changedCells[5] is Penguin)
    }

}

