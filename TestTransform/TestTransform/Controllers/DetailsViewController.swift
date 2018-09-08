//
//  DetailsViewController.swift
//  TestTransform
//
//  Created by Adela Toderici on 2018-09-06.
//  Copyright © 2018 Adela Toderici. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var courageLabel: UILabel!
    @IBOutlet weak var firepowerLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    
    var transformer: Transformer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = nameLabel.text {
            nameLabel.text = name + " " + transformer.name
        }
        if let type = typeLabel.text {
            typeLabel.text = type + " " + (transformer.type.hashValue == 0 ? "Autobot" : "Decepticon")
        }
        if let strength = strengthLabel.text {
            strengthLabel.text = strength + " " + String(transformer.strength)
        }
        if let intelligence = intelligenceLabel.text {
            intelligenceLabel.text = intelligence + " " + String(transformer.intelligence)
        }
        if let speed = speedLabel.text {
            speedLabel.text = speed + " " + String(transformer.speed)
        }
        if let endurance = enduranceLabel.text {
            enduranceLabel.text = endurance + " " + String(transformer.endurance)
        }
        if let rank = rankLabel.text {
            rankLabel.text = rank + " " + String(transformer.rank)
        }
        if let courage = courageLabel.text {
            courageLabel.text = courage + " " + String(transformer.courage)
        }
        if let firepower = firepowerLabel.text {
            firepowerLabel.text = firepower + " " + String(transformer.firepower)
        }
        if let skill = skillLabel.text {
            skillLabel.text = skill + " " + String(transformer.skill)
        }
    }

}
