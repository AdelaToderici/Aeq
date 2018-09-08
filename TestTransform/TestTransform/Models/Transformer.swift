//
//  Transformer.swift
//  TestTransform
//
//  Created by Adela Toderici on 2018-09-06.
//  Copyright © 2018 Adela Toderici. All rights reserved.
//

import UIKit

enum TransformerType {
    case Autobot
    case Decepticon
}

struct Transformer {
    var name: String
    var type: TransformerType
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
}
