//
//  LinearRegression.swift
//  Test
//
//  Created by 王蛟 on 6/24/23.
//

import Foundation

/// This is a **Linear Regression** class to train weights for predictions.
class LinearRegression {
    /**
        - Parameters
            - dataX:the feature data that are provided for training.
            - dataY: the label data for training.
     */
    /// **dataX** are the feature data that are provided for training.
    let dataX: [[Double]]
    /// **dataY** are the label data for training.
    let dataY: [Double]
    /// **dimension** is the number of the features
    let dimension: Int
    var weights: [Double]
    let learningRate: Double
    let numIterations: Int
    
    init(dataX: [[Double]], dataY: [Double], learningRate: Double, numIterations: Int) {
        self.dataX = dataX
        self.dataY = dataY
        self.dimension = dataX[0].count
        self.weights = Array(repeating: 0.0, count: dimension)
        self.learningRate = learningRate
        self.numIterations = numIterations
    }
    
    func train() {
        for _ in 0..<numIterations {
            var gradients = Array(repeating: 0.0, count: dimension)
            
            for i in 0..<dataX.count {
                let prediction = predict(dataX[i])
                let error = prediction - dataY[i]
                
                for j in 0..<dimension {
                    gradients[j] += error * dataX[i][j]
                }
            }
            
            for j in 0..<dimension {
                weights[j] -= learningRate * gradients[j] / Double(dataX.count)
            }
        }
    }
    
    func computeLoss() -> Double {
            var loss = 0.0
            
            for i in 0..<dataX.count {
                let prediction = predict(dataX[i])
                let error = prediction - dataY[i]
                loss += error * error
            }
            
            return loss / (2.0 * Double(dataX.count))
        }
    
    func predict(_ input: [Double]) -> Double {
        var output = 0.0
        
        for i in 0..<dimension {
            output += weights[i] * input[i]
        }
        
        return output
    }
}
