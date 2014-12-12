//
//  Geometry.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import Foundation
import UIKit

// Takes a CGVector and a CGFloat
// Returns a new CGFloat where each component m has been multiplied by m.

func vectorMultiply(v: CGVector, m: CGFloat) -> CGVector {
    return CGVectorMake(v.dx * m, v.dy * m)
}

// Takes two CGPoints
// Returns a CGVector representing the distance between the two points
func vectorBetweenPoints(p1: CGPoint, p2: CGPoint) -> CGVector {
    return CGVectorMake(p2.x - p1.x, p2.y - p1.y)
}

// Takes a CGVector
// Returns a CGFloat containing the length of the vector
func vectorLength(v: CGVector) -> CGFloat {
    return CGFloat(sqrtf(powf(Float(v.dx),2) + powf(Float(v.dy), 2)))
}

// Takes two CG Points
//Returns a CGFloat containing the distance between them
func pointDistance(p1: CGPoint, p2: CGPoint) -> CGFloat {
    return CGFloat(sqrtf(powf(Float(p2.x - p1.x),2) + powf(Float(p2.y - p1.y), 2)))
}

