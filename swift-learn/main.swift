//
//  main.swift
//  Test
//
//  Created by 王蛟 on 6/24/23.
//

import Foundation
let dimension = 3
let (dataX,dataY) = generateData(dimensions: dimension)

func use_Knn(){
    let k = 3
    let knn = KNNClassifier(dimension: dimension, k:k, dataX: dataX, dataY: dataY)
    let input = [2.5, 3.5, 2.0]
    var each_prediction:Int
    var correct=0
    for i in 0...dataX.count-1{
        each_prediction = knn.predict(input: dataX[i])!
        if each_prediction == dataY[i]{
            correct+=1
        }
    }
    print("correct:\(correct)")
    let Acc:Double
    Acc = Double(correct/dataX.count)
    print("Acc: \(Acc)")
    
    if let predictedLabel = knn.predict(input: input) {
        print("Predicted label: \(predictedLabel)")
    } else {
        print("Invalid input")
    }
}

func use_LinearRegression(){
    // Example usage:
    let dataX: [[Double]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    let dataY: [Double] = [10, 20, 30]
    let linearRegression = LinearRegression(dataX: dataX, dataY: dataY, learningRate: 0.01, numIterations: 1000)
    linearRegression.train()
    let input: [Double] = [2, 4, 10]
    let prediction = linearRegression.predict(input)
    let loss = linearRegression.computeLoss()
    print("Prediction:", prediction)
    print("Loss: \(loss)")
}

func use_LogisticRegression(){
//    let dataX = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0], [7.0, 8.0, 9.0]]
//    let dataY = [0, 1, 0]
    let logisticRegression = LogisticRegression(dataX: dataX, dataY: dataY, learningRate: 0.1, numIterations: 100)
    logisticRegression.train()
    let testX = [2.0, 3.0, 3.0]
    let prediction = logisticRegression.predict(testX)
    print("Prediction:", prediction)
}

func use_Bayes(){
    let bayes = Bayes(DataX: dataX, DataY: dataY)
    // 预测新的实例
    let testVector: [Double] = [2.2, 3.5, 2.1]
    let prediction = bayes.predict(testVector: testVector)
    print("预测的类别为：\(prediction)")
}

use_Bayes()
