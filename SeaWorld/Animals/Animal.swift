//
//  Animal.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 22/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

class Animal {

    var turnsWithoutBreed: UInt = 0

    func turn(curr: Int, available: WorldCells ) -> WorldCells {
        turnsWithoutBreed += 1
        return [:]
    }
}
