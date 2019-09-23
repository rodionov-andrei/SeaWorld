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

    func testBreedOnTime() {
        var world = World(xCount: 3, yCount: 3, cells: WorldCells())
        let testPenguin = Penguin()
        world.cells = ([0: Orca(), 1: Penguin(), 2: Orca(),
                        3: nil, 4: testPenguin, 5: Penguin(),
                        6: Orca(), 7: Orca(), 8: Orca()])
        let availableCells = world.availableCells(forAnimalAt: 4)

        // 1st turn
        var changedCells = testPenguin.turn(curr: 4, available: availableCells)
        XCTAssertTrue(changedCells[4]! == nil)
        XCTAssertTrue(changedCells[3] is Penguin)

        // 2nd turn
        changedCells = testPenguin.turn(curr: 3,
                                        available: changedCells)
        XCTAssertTrue(changedCells[3]! == nil)
        XCTAssertTrue(changedCells[4] is Penguin)

        // 3rd turn. breed
        changedCells = testPenguin.turn(curr: 4, available: changedCells)
        XCTAssertTrue(changedCells[3] is Penguin)
        XCTAssertTrue(changedCells[4] is Penguin)

    }

}
