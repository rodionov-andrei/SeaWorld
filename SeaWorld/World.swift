//
//  World.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 11/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//


struct WorldCell {

    var entity: Entity
    var absCoordinate: UInt
}

struct World {

    let cells: [WorldCell]

    private var xCount: UInt
    private var yCount: UInt
    private var count: UInt {
        return xCount * yCount
    }

    func neighboorCells(curr: UInt) -> [UInt] {

        var topLeft = curr - xCount - 1, top = curr - xCount, topRight = curr - xCount + 1,
            left = curr - 1, right = curr + 1,
            bottomLeft = curr + xCount - 1, bottom = curr + xCount, bottomRight = curr + xCount + 1

        let currY = UInt(Double(curr % xCount).rounded(.down))
        if /* on the top edge*/ currY == 0 {
            top += xCount * yCount
            topLeft += xCount * yCount
            topRight += xCount * yCount
        } /*bottom edge*/ else if currY == yCount - 1 {
            bottom -= xCount * yCount
            bottomLeft -= xCount * yCount
            bottomRight -= xCount * yCount
        }

        if /* left edge*/ curr % xCount == 0 {
            left += xCount
            topLeft += xCount
            bottomLeft += xCount
        } /* right edge */ else if (curr + 1) % xCount  == 0 {
            right -= xCount
            topRight -= xCount
            bottomRight -= xCount
        }

        return [topLeft, top, topRight, left, right, bottomLeft, bottom, bottomRight]
    }
}
