//
//  World.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 11/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

typealias WorldCells = [Int: Animal?]

/*
 World model.
 */
struct World {

    let xCount: Int
    let yCount: Int

    var cells = WorldCells()

    func availableCells(forAnimalAt coord: Int) -> WorldCells {
        let availableCoords = neighborCells(coord)
        return cells.filter { availableCoords.contains($0.key) }
    }

    func neighborCells(_ forCoord: Int) -> [Int] {

        var topLeft = forCoord - xCount - 1, top = forCoord - xCount, topRight = forCoord - xCount + 1,
            left = forCoord - 1, right = forCoord + 1,
            bottomLeft = forCoord + xCount - 1, bottom = forCoord + xCount, bottomRight = forCoord + xCount + 1

        let currY = Int(Double(forCoord % xCount).rounded(.down))
        if /* on the top edge*/ currY == 0 {
            top += xCount * yCount
            topLeft += xCount * yCount
            topRight += xCount * yCount
        } /*bottom edge*/ else if currY == yCount - 1 {
            bottom -= xCount * yCount
            bottomLeft -= xCount * yCount
            bottomRight -= xCount * yCount
        }

        if /* left edge*/ forCoord % xCount == 0 {
            left += xCount
            topLeft += xCount
            bottomLeft += xCount
        } /* right edge */ else if (forCoord + 1) % xCount  == 0 {
            right -= xCount
            topRight -= xCount
            bottomRight -= xCount
        }

        return [topLeft, top, topRight, left, right, bottomLeft, bottom, bottomRight, forCoord]
    }
}
