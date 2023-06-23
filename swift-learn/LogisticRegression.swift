//
//  LogisticRegression.swift
//  Test
//
//  Created by 王蛟 on 6/25/23.
//

import Foundation

class LogisticRegression {
    let dataX: [[Double]]
    let dataY: [Int]
    let dimension: Int
    var weights: [Double]
    let learningRate: Double
    let numIterations: Int
    
    init(dataX: [[Double]], dataY: [Int], learningRate: Double, numIterations: Int) {
        self.dataX = dataX
        self.dataY = dataY
        self.dimension = dataX[0].count
        self.weights = Array(repeating: 0.0, count: dimension)
        self.learningRate = learningRate
        self.numIterations = numIterations
    }
    
    private func sigmoid(_ z: Double) -> Double {
        return 1.0 / (1.0 + exp(-z))
    }
    
    private func hypothesis(_ x: [Double]) -> Double {
        var z = 0.0
        for i in 0..<dimension {
            z += weights[i] * x[i]
        }
        return sigmoid(z)
    }
    
    private func updateWeights() {
        var gradient = Array(repeating: 0.0, count: dimension)
        
        for i in 0..<dataX.count {
            let x = dataX[i]
            let y = Double(dataY[i])
            let h = hypothesis(x)
            
            for j in 0..<dimension {
                gradient[j] += (h - y) * x[j]
            }
        }
        
        for j in 0..<dimension {
            weights[j] -= learningRate * gradient[j] / Double(dataX.count)
        }
    }
    
    func train() {
        for _ in 0..<numIterations {
            updateWeights()
        }
    }
    
    func predict(_ x: [Double]) -> Int {
        let h = hypothesis(x)
        return h >= 0.5 ? 1 : 0
    }
}
