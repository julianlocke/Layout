//
//  Util.swift
//  Layout
//
//  Created by Cameron Pulsford on 11/25/16.
//  Copyright © 2016 SMD. All rights reserved.
//

import Foundation

func zip3<V1, V2, V3>(_ s1: [V1], _ s2: [V2], _ s3: [V3]) -> [(V1, V2, V3)] {
    var value: [(V1, V2, V3)] = []

    for (idx, value1) in s1.enumerated() {
        let value2 = s2[idx]
        let value3 = s3[idx]
        value.append((value1, value2, value3))
    }

    return value
}
