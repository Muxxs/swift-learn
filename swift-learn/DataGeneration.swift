//
//  DataGeneration.swift
//  Test
//
//  Created by 王蛟 on 6/25/23.
//

import Foundation

func generateData(dimensions: Int) -> ([[Double]], [Int]) {
    var dataX: [[Double]] = []
    var dataY: [Int] = []
    
    for i in 1...4 {
        var dataPoint: [Double] = []
        
        for _ in 1...dimensions {
            let value = Double.random(in: 1...4) // 在范围 [1, 4] 内生成随机数
            dataPoint.append(value)
        }
        
        dataX.append(dataPoint)
        dataY.append(i % 2) // 交替生成 0 和 1
    }
    
    return (dataX, dataY)
}
