//
//  Bayes.swift
//  Test
//
//  Created by 王蛟 on 6/25/23.
//

import Foundation

/// 多维贝叶斯分类器
class Bayes {
    var DataX: [[Double]]
    var DataY: [Int]
    var Dimension: Int
    var classes: [Int: [[Double]]] = [:]
    var classProbabilities: [Int: Double] = [:]
    var meanAndVarianceByClass: [Int: [(mean: Double, variance: Double)]] = [:]
    
    /// 初始化
    /// - Parameters:
    ///   - DataX: 特征值数组
    ///   - DataY: 类别数组
    init(DataX: [[Double]], DataY: [Int]) {
        self.DataX = DataX
        self.DataY = DataY
        self.Dimension = DataX[0].count
        self.train()
    }
    
    /// 训练模型
    func train() {
        self.splitByClass()
        self.calculateClassProbabilities()
        self.calculateMeanAndVarianceByClass()
    }
    
    /// 按类别划分数据
    func splitByClass() {
        for i in 0..<DataX.count {
            let vector = DataX[i]
            let classValue = DataY[i]
            if classes[classValue] == nil {
                classes[classValue] = []
            }
            classes[classValue]?.append(vector)
        }
    }
    
    /// 计算各类别的概率
    func calculateClassProbabilities() {
        let totalData = Double(DataX.count)
        for (classValue, instances) in classes {
            classProbabilities[classValue] = Double(instances.count) / totalData
        }
    }
    
    /// 计算各类别的平均值和方差
    func calculateMeanAndVarianceByClass() {
        for (classValue, instances) in classes {
            var summary = [(mean: Double, variance: Double)]()
            for i in 0..<Dimension {
                let column = instances.map { $0[i] }
                let mean = column.reduce(0, +) / Double(column.count)
                let variance = column.map { pow($0 - mean, 2.0) }.reduce(0, +) / Double(column.count)
                summary.append((mean, variance))
            }
            meanAndVarianceByClass[classValue] = summary
        }
    }
    
    /// 计算概率
    /// - Parameters:
    ///   - x: 特征值
    ///   - mean: 平均值
    ///   - variance: 方差
    /// - Returns: 概率
    func calculateProbability(x: Double, mean: Double, variance: Double) -> Double {
        let exponent = exp(-((x - mean) * (x - mean)) / (2 * variance))
        return (1 / sqrt(2 * Double.pi * variance)) * exponent
    }
    
    /// 预测类别
    /// - Parameter testVector: 测试向量
    /// - Returns: 预测的类别
    func predict(testVector: [Double]) -> Int {
        var bestClass = -1
        var bestProb = 0.0
        for (classValue, classSummaries) in meanAndVarianceByClass {
            var classProbability = classProbabilities[classValue]!
            for i in 0..<testVector.count {
                let mean = classSummaries[i].mean
                let variance = classSummaries[i].variance
                let x = testVector[i]
                classProbability *= calculateProbability(x: x, mean: mean, variance: variance)
            }
            if classProbability > bestProb {
                bestProb = classProbability
                bestClass = classValue
            }
        }
        return bestClass
    }
}
