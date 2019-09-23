//
//  Penguin.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 13/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

final class Penguin: Animal {

    private let breedPeriod = Consts.penguinBreedPeriod

    override func turn(curr: Int, available: WorldCells) -> WorldCells {
        guard !isMadeTurn else { return available }
        _ = super.turn(curr: curr, available: available)
        guard let currEntity = available[curr] else { fatalError() }

        var modifiedCells = available

        if (turnsWithoutBreed % breedPeriod) == 0, let spare = available.first(where: { $0.value == nil }) {
            modifiedCells.updateValue(Penguin(), forKey: spare.key)
            turnsWithoutBreed = 0
        } else if let spare = available.first(where: { $0.value == nil }) {
            modifiedCells.updateValue(currEntity, forKey: spare.key)
            modifiedCells.updateValue(nil, forKey: curr)
        } else {
            // surrounded by animals
        }

        return modifiedCells
    }
}
