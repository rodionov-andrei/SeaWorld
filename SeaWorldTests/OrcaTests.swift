//
//  OrcaTests.swift
//  SeaWorldTests
//
//  Created by Andrey Rodionov on 23/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import SeaWorld

class OrcaTests: XCTestCase {

    func testOrcaDies() {
        var world = World(xCount: 3, yCount: 3, cells: WorldCells())
        let testOrca = Orca()
        world.cells = ([0: Orca(), 1: Orca(), 2: Orca(),
                        3: Orca(), 4: testOrca, 5: Orca(),
                        6: Orca(), 7: Orca(), 8: Orca()])
        let availableCells = world.availableCells(forAnimalAt: 4)

        // 1st turn
        var changedCells = testOrca.turn(curr: 4, available: availableCells)
        XCTAssertTrue(changedCells[4] is Orca)

        // 2nd turn
        changedCells = testOrca.turn(curr: 4, available: availableCells)
        XCTAssertTrue(changedCells[4] is Orca)

        // 3rd turn. Orca dies
        changedCells = testOrca.turn(curr: 4, available: availableCells)
        XCTAssertTrue(changedCells[4]! == nil)
    }

}
