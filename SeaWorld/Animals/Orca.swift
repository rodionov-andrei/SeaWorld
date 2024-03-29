//
//  Orca.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 22/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

final class Orca: Animal {

    private var turnsWithoutFeed = 0
    private let breedPeriod = Consts.orcaBreedPeriod
    private let maxTurnsWithoutFood = Consts.orcaMaxTurnsWithoutFood

    override func turn(curr: Int, available: WorldCells) -> WorldCells {
        guard !isMadeTurn else { return available }
        _ = super.turn(curr: curr, available: available)
        guard let currEntity = available[curr] else { fatalError() }

        turnsWithoutFeed += 1
        var modifiedCells = available
        // Eat
        if let penguin = available.first(where: { $0.value is Penguin }) {
            modifiedCells.updateValue(nil, forKey: curr)
            modifiedCells.updateValue(currEntity, forKey: penguin.key)
            turnsWithoutFeed = 0
            return modifiedCells
        }
        // Die?
        if turnsWithoutFeed == maxTurnsWithoutFood {
            modifiedCells.updateValue(nil, forKey: curr)
            return modifiedCells
        }
        // Breed or move
        if turnsWithoutBreed >= breedPeriod, let spare = available.first(where: { $0.value == nil }) {
            modifiedCells.updateValue(Orca(), forKey: spare.key)
            turnsWithoutBreed = 0
        } else if let spare = available.first(where: { $0.value == nil }) {
            modifiedCells.updateValue(currEntity, forKey: spare.key)
            modifiedCells.updateValue(nil, forKey: curr)
        }

        return modifiedCells
    }
}
