//
//  Penguin.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 13/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class Penguin: Animal {

    private let breedPerios = 3

    override func turn(curr: (key: Int, value: Entity), available: [Int : Entity]) -> [Int : Entity] {
        _ = super.turn(curr: curr, available: available)

        var modifiedCells = available

        if turnsWithoutBreed >= breedPerios, let spare = available.first(where: { $0.value is Void }) {
            modifiedCells.updateValue(Penguin(), forKey: spare.key)
            turnsWithoutBreed = 0
        } else if let spare = available.first(where: { $0.value is Void }) {
            modifiedCells.updateValue(curr.value, forKey: spare.key)
            modifiedCells.updateValue(Void(), forKey: curr.key)
        } else {
            // surrounded by animals
        }

        return modifiedCells
    }
}

class Orca: Animal {

    private var turnsWithoutFeed = 0
    private let breedPeriod = 8

    // что должна предпочесть касатка: умереть и оставить потомство или сьесть пингвина и
    // выжить?
    override func turn(curr: (key: Int, value: Entity), available: [Int : Entity]) -> [Int : Entity] {
        _ = super.turn(curr: curr, available: available)

        turnsWithoutFeed += 1
        var modifiedCells = available

        if let penguin = available.first(where: { $0.value is Penguin }) {
            modifiedCells.updateValue(Void(), forKey: curr.key)
            modifiedCells.updateValue(curr.value, forKey: penguin.key)
            turnsWithoutFeed = 0
        } else if turnsWithoutBreed >= breedPeriod, let spare = available.first(where: { $0.value is Void }) {
            modifiedCells.updateValue(Orca(), forKey: spare.key)
            turnsWithoutBreed = 0
        } else if let spare = available.first(where: { $0.value is Void }) {
            modifiedCells.updateValue(curr.value, forKey: spare.key)
            modifiedCells.updateValue(Void(), forKey: curr.key)
        } else {
            // surrounded by orcas
        }

        return modifiedCells
    }
}


class Animal: Entity {
    var breedPeriod: UInt = 8
}

class Entity {

    var turnsWithoutBreed: UInt = 0

    func turn(curr: (key: Int, value: Entity), available: [Int : Entity] ) -> [Int : Entity] {
        turnsWithoutBreed += 1
        return [:]
    }
}

class Void: Entity {

}
