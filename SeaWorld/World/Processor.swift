//
//  Processor.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 22/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

/*

 */
final class Processor {

    var currentTurn = 0
    var world: World

    init(worldXCount: Int = 8, worldYCount: Int = 8, orcaPart: Double = 0.05, penguinPart: Double = 0.5) {
        //инициализация мира
        world = World(xCount: worldXCount, yCount: worldYCount, cells: [:])

        // заселение
        world.cells = populate(orcaPart: orcaPart, penguinPart: penguinPart)
    }

    func turn() {
        world.cells.forEach { cell in
            let availableCells = world.availableCells(forAnimalAt: cell.key)
            guard let entity = cell.value else { return }
            let newStates = entity.turn(curr: cell.key, available: availableCells)
            world.cells.merge(newStates) { (_, new) in new }
        }
    }

    /*
     Populate world with creatures.
     */
    private func populate(orcaPart: Double, penguinPart: Double) -> [Int: Animal] {
        guard orcaPart + penguinPart <= 1 else {
            fatalError("Orca and penguin populations exceed maximum world capacity")
        }
        let totalCells = world.xCount * world.yCount

        let totalOrca = Int((Double(totalCells) * orcaPart).rounded(.down))
        let totalPenguin = Int((Double(totalCells) * penguinPart).rounded(.down))

        let orca = Array(repeating: Orca(), count: totalOrca)
        let penguin = Array(repeating: Penguin(), count: totalPenguin)
        let spare = Array(repeating: Animal(), count: Int(totalCells) - totalPenguin - totalOrca)

        let allEntities = (orca + penguin + spare).shuffled()

        var state = [Int: Animal]()
        for (index, entity) in allEntities.enumerated() {
            state.updateValue(entity, forKey: index)
        }
        return state
    }
}
