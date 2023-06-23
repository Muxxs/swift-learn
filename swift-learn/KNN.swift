//
//  KNN.swift
//  Test
//
//  Created by 王蛟 on 6/24/23.
//

import Foundation

class KNNClassifier {
    let dimension: Int
    let k: Int
    let dataX: [[Double]]
    let dataY: [Int]
    
    init(dimension: Int, k: Int, dataX: [[Double]], dataY: [Int]) {
        self.dimension = dimension
        self.k = k
        self.dataX = dataX
        self.dataY = dataY
    }
    
    func predict(input: [Double]) -> Int? {
        guard input.count == dimension else {
            print("Invalid input dimension")
            return nil
        }
        
        var distances = [(index: Int, distance: Double)]()
        
        for i in 0..<dataX.count {
            let distance = euclideanDistance(dataX[i], input)
            distances.append((index: i, distance: distance))
        }
        
        distances.sort { $0.distance < $1.distance }
        
        var labelCounts = [Int: Int]() // 存储每个类别的出现次数
        
        for i in 0..<k {
            let index = distances[i].index
            let label = dataY[index]
            
            if let count = labelCounts[label] {
                labelCounts[label] = count + 1
            } else {
                labelCounts[label] = 1
            }
        }
        
        // 找到出现次数最多的类别
        var maxCount = 0
        var predictedLabel: Int?
        
        for (label, count) in labelCounts {
            if count > maxCount {
                maxCount = count
                predictedLabel = label
            }
        }
        
        return predictedLabel
    }
    
    private func euclideanDistance(_ point1: [Double], _ point2: [Double]) -> Double {
        var sum: Double = 0
        
        for i in 0..<dimension {
            let diff = point1[i] - point2[i]
            sum += diff * diff
        }
        
        return sqrt(sum)
    }
}
