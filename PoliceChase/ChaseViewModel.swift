//
//  ChaseViewModel.swift
//  PoliceChase
//
//  Created by Shivam on 25/01/24.
//

import Foundation

class ChaseViewModel {
    
    var row: Int
    var column: Int
    var randomPosGhost: Int = 0
    var randomPosPolice: Int = 0
    
    static let ghost = "👻"
    static let police = "👮🏼"
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    var cellCount: Int {
        return self.row * self.column
    }
    
    func findGhostPosition() {
        self.randomPosGhost = Int.random(in: 0..<self.cellCount)
    }
    
    func findPolicePosition() {
        let ghostCurrentRow = self.randomPosGhost / self.column
        let ghostCurrentCol = self.randomPosGhost % self.column
        
        
        var avoidableRows = stride(from: (self.column * ghostCurrentRow),
                                   to: (self.column * ghostCurrentRow) + self.column,
                                   by: 1).map { $0 }
        let avoidableCols = stride(from: ghostCurrentCol,
                                   through: self.column * (self.row - 1) + ghostCurrentCol,
                                   by: self.column).map { $0 }
        
        avoidableRows.append(contentsOf: avoidableCols)
        
        var grid = stride(from: 0, to: self.cellCount, by: 1).map { $0 }
        grid.removeAll { avoidableRows.contains($0) }
        
        self.randomPosPolice = grid.randomElement() ?? 0
    }
}
