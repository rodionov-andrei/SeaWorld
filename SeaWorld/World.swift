//
//  World.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 11/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

typealias WorldCell = (coordinate: Int, entity: Entity)
struct WorldState {

    var state: [Int: Entity]

    func entities(at coords: [Int]) -> [Int: Entity] {
        return state.filter { coords.contains($0.key) }
    }
}


struct World {

    let xCount: Int
    let yCount: Int

    private var count: Int {
        return xCount * yCount
    }

    func neighborCells(_ currentCoord: Int) -> [Int] {

        var topLeft = currentCoord - xCount - 1, top = currentCoord - xCount, topRight = currentCoord - xCount + 1,
            left = currentCoord - 1, right = currentCoord + 1,
            bottomLeft = currentCoord + xCount - 1, bottom = currentCoord + xCount, bottomRight = currentCoord + xCount + 1

        //TODO: вынести в отдельную функцию
        let currY = Int(Double(currentCoord % xCount).rounded(.down))
        if /* on the top edge*/ currY == 0 {
            top += xCount * yCount
            topLeft += xCount * yCount
            topRight += xCount * yCount
        } /*bottom edge*/ else if currY == yCount - 1 {
            bottom -= xCount * yCount
            bottomLeft -= xCount * yCount
            bottomRight -= xCount * yCount
        }

        if /* left edge*/ currentCoord % xCount == 0 {
            left += xCount
            topLeft += xCount
            bottomLeft += xCount
        } /* right edge */ else if (currentCoord + 1) % xCount  == 0 {
            right -= xCount
            topRight -= xCount
            bottomRight -= xCount
        }

        return [topLeft, top, topRight, left, right, bottomLeft, bottom, bottomRight]
    }
}

class Processor {

    var currentTurn = 0
    let world: World
    var worldState = WorldState(state: [:])

    init() {
        //инициализация мира
        world = World(xCount: 8, yCount: 8)

        // заселение
        worldState.state = populate()
    }

    func turn() {
        worldState.state.forEach { cell in
            let entetyInCell = cell.value
            let availableCoords = world.neighborCells(Int(cell.key))
            let availableCells = worldState.entities(at: availableCoords)
            let newStates = entetyInCell.turn(curr: cell, available: availableCells)
            worldState.state.merge(newStates) { (_, new) in new }
        }
    }

    func populate() -> [Int: Entity] {
        let totalCells: Double = 56
        let orcaPart = 0.05
        let penguinPart = 0.5

        let totalOrca = Int((totalCells * orcaPart).rounded(.down))
        let totalPenguin = Int((totalCells * penguinPart).rounded(.down))

        let orca = Array(repeating: Orca(), count: totalOrca)
        let penguin = Array(repeating: Penguin(), count: totalPenguin)
        let spare = Array(repeating: Entity(), count: Int(totalCells) - totalPenguin - totalOrca)

        var allEntities = [Entity]()
        allEntities.append(contentsOf: orca)
        allEntities.append(contentsOf: penguin)
        allEntities.append(contentsOf: spare)

        allEntities.shuffle()

        var state = [Int: Entity]()

        for (index, entity) in allEntities.enumerated() {
            state.updateValue(entity, forKey: index)
        }
        return state
    }


}
