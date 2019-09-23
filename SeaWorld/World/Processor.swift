//
//  Processor.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 22/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

final class Processor {

    private var currentTurn = 0
    var world: World

    init(worldXCount: Int = Consts.worldXSize, worldYCount: Int = Consts.worldYSize,
         orcaPart: Double = Consts.orcaFractionOnStart, penguinPart: Double = Consts.penguinFractionOnStart) {
        world = World(xCount: worldXCount, yCount: worldYCount, cells: [:])
        world.cells = populate(orcaPart: orcaPart, penguinPart: penguinPart)
    }

    func turn() {
        world.cells.forEach { cell in
            let availableCells = world.availableCells(forAnimalAt: cell.key)
            guard let entity = cell.value else { return }
            let newStates = entity.turn(curr: cell.key, available: availableCells)
            world.cells.merge(newStates) { (_, new) in new }
        }
        world.cells.forEach { cell in
            cell.value?.prepareForNextTurn()
        }
    }

    /**
      Populate world with creatures.

     - Parameter orcaPart: part of all cells occupied by orcas. From 0 to 1.
     - Parameter penguinPart: part of all cells occupied by penguins. From 0 to 1.

     - Returns: World cells filled with animals or nil. Nil is equalent to no animal.
     */
    private func populate(orcaPart: Double, penguinPart: Double) -> WorldCells {
        guard orcaPart + penguinPart <= 1 else {
            fatalError("Orca and penguin populations exceed maximum world capacity")
        }
        let totalCells = world.xCount * world.yCount

        let totalOrca = Int((Double(totalCells) * orcaPart).rounded(.down))
        let totalPenguin = Int((Double(totalCells) * penguinPart).rounded(.down))
        let totalSpare = Int(totalCells) - totalPenguin - totalOrca

        let allEntities: [Animal?] = (.init(repeating: Orca(), count: totalOrca) +
                                      .init(repeating: Penguin(), count: totalPenguin) +
                                      .init(repeating: nil, count: totalSpare)).shuffled()

        var state = WorldCells()
        for (index, entity) in allEntities.enumerated() {
            state.updateValue(entity, forKey: index)
        }
        return state
    }
}
