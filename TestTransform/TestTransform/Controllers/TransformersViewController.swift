//
//  TransformersViewController.swift
//  TestTransform
//
//  Created by Adela Toderici on 2018-09-06.
//  Copyright © 2018 Adela Toderici. All rights reserved.
//

import UIKit

class TransformersViewController: UIViewController {
    
    @IBOutlet weak var autobotsTableView: UITableView!
    @IBOutlet weak var decepticonsTableView: UITableView!
    var autobots: [Transformer] = []
    var decepticons: [Transformer] = []
    var addTransformerVC = AddTransformerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        addTransformerVC.transformerDelegate = self
        
        autobotsTableView.dataSource = self
        autobotsTableView.delegate = self
        decepticonsTableView.dataSource = self
        decepticonsTableView.delegate = self
        
        autobotsTableView.tableFooterView = UIView()
        decepticonsTableView.tableFooterView = UIView()
        
        let soundwave = Transformer(name: "Soundwave", type: .Decepticon, strength: 8, intelligence: 9, speed: 2, endurance: 6, rank: 7, courage: 5, firepower: 6, skill: 10)
        let bluestreak = Transformer(name: "Bluestreak", type: .Autobot, strength: 6, intelligence: 6, speed: 7, endurance: 9, rank: 5, courage: 2, firepower: 9, skill: 7)
        let hubcap = Transformer(name: "Hubcap", type: .Autobot, strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 4, courage: 4, firepower: 4, skill: 4)
        autobots = [bluestreak, hubcap]
        decepticons = [soundwave]
    }
    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addVC = storyboard.instantiateViewController(withIdentifier: "addTransformerId") as? AddTransformerViewController {
            addVC.transformerDelegate = self
            self.present(addVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func startFightAction(_ sender: Any) {
        startFight()
    }
    

}

// MARK: Private methods
// ****** Here is the core solution for Part 2 ******
extension TransformersViewController {
    
    func startFight() {
        if (autobots.count == 0 || decepticons.count == 0) {
            showAlert(message: "Add opponent transformers to be able to start a battle.")
            return
        }
        
        // sort transformers teams per rank
        let autobotArray = autobots.sorted(by: { $0.rank < $1.rank })
        let decepticonsArray = decepticons.sorted(by: { $0.rank < $1.rank })
        
        var autobotResult = 0
        var decepticonResult = 0
        var battles = 0
        let minValue: Int = min(autobots.count - 1, decepticons.count - 1)
        
        var j = 0
        for i in 0...minValue {
            j = i
            
            let autobot = autobotArray[i]
            let decepticon = decepticonsArray[j]
            
            // Optimus Prime vs. Predaking or duplicates -> all competitors destroyed
            if ((autobot.name == "Optimus Prime" || autobot.name == "Predaking") &&
                (decepticon.name == "Optimus Prime" || decepticon.name == "Predaking")) {
                allCompetitorsDestroyed()
                return
            }
            
            battles += 1
            
            // Optimus Prime || Predaking -> automatically wins
            if (autobot.name == "Optimus Prime" || autobot.name == "Predaking") {
                autobotResult += 1
                decepticons.remove(at: j)
                continue
            }
            
            if (decepticon.name == "Optimus Prime" || decepticon.name == "Predaking") {
                decepticonResult += 1
                autobots.remove(at: i)
                continue
            }
            
            // >= 4 courage && >= 3 strength -> fighter wins
            if (autobot.courage - decepticon.courage >= 4 && autobot.strength - decepticon.strength >= 3) {
                autobotResult += 1
                decepticons.remove(at: j)
                continue
            }
            if (decepticon.courage - autobot.courage >= 4 && decepticon.strength - autobot.strength >= 3) {
                decepticonResult += 1
                autobots.remove(at: i)
                continue
            }
            
            // >= 3 skill -> fighter wins
            if (abs(autobot.skill - decepticon.skill) >= 3) {
                if (autobot.skill > decepticon.skill) {
                    autobotResult += 1
                    decepticons.remove(at: j)
                } else {
                    decepticonResult += 1
                    autobots.remove(at: i)
                }
                continue
            }
            
            // higher overall rating: strength + intelligence + speed + endurance + firepower -> wins
            if (overallRating(autobot) > overallRating(decepticon)) {
                autobotResult += 1
                decepticons.remove(at: j)
            }
            else if (overallRating(decepticon) > overallRating(autobot)) {
                decepticonResult += 1
                autobots.remove(at: i)
            }
            // tie overall rating
            else {
                autobots.remove(at: i)
                decepticons.remove(at: j)
            }
        }
        
        // show result
        if (autobotResult > decepticonResult) {
            showAlert(message: createMessage(battlesNr: battles, winners: autobots, skipped: decepticons))
        }
        else if (autobotResult < decepticonResult) {
            showAlert(message: createMessage(battlesNr: battles, winners: decepticons, skipped: autobots))
        }
        else {
            showAlert(message: createMessage(battlesNr: battles, winners: [], skipped: []))
        }
        
        autobotsTableView.reloadData()
        decepticonsTableView.reloadData()
    }
    
    func overallRating(_ transformer: Transformer) -> Int {
        return transformer.strength + transformer.intelligence + transformer.speed + transformer.endurance + transformer.firepower
    }
    
    func allCompetitorsDestroyed() {
        showAlert(message: "All competitors destroyed!")
        autobots = []
        decepticons = []
        autobotsTableView.reloadData()
        decepticonsTableView.reloadData()
    }
    
    func showAlert(message: String) {
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    func createMessage(battlesNr: Int, winners:[Transformer], skipped:[Transformer]) -> String {
        let winningTeam = findWinningTeam(winners)
        let winnersNames = concatenateNames(winners)
        let skippedTeam = findSkipTeam(winners)
        let skippedNames = concatenateNames(skipped)
        
        let result = """
        \(battlesNr) battle
        Winning team \(winningTeam): \(winnersNames)
        Survivors from the losing team \(skippedTeam): \(skippedNames)
        """
        return result
    }
    
    func concatenateNames(_ array: [Transformer]) -> String {
        var result = ""
        for transformer in array {
            result += transformer.name + " "
        }
        
        return result
    }
    
    func findWinningTeam(_ winners: [Transformer]) -> String {
        guard let winner = winners.first else {
            return ""
        }
        
        switch winner.type {
        case .Autobot:
            return "(Autobot)"
        case .Decepticon:
            return "(Decepticon)"
        }
    }
    
    func findSkipTeam(_ winners: [Transformer]) -> String {
        guard let winner = winners.first else {
            return ""
        }
        
        switch winner.type {
        case .Autobot:
            return "(Decepticon)"
        case .Decepticon:
            return "(Autobot)"
        }
    }
}

extension TransformersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == autobotsTableView { return autobots.count }
        if tableView == decepticonsTableView { return decepticons.count }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == autobotsTableView && autobots.count > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutobotCell", for: indexPath)
            let transformer = autobots[indexPath.row]
            cell.textLabel?.text = transformer.name
            return cell
        }
        if (tableView == decepticonsTableView && decepticons.count > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DecepticonCell", for: indexPath)
            let transformer = decepticons[indexPath.row]
            cell.textLabel?.text = transformer.name
            return cell
        }
        return UITableViewCell()
    }
}

extension TransformersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "detailsIdentifier") as? DetailsViewController {
            if tableView == autobotsTableView {
                let transformer = autobots[indexPath.row]
                detailsVC.transformer = transformer
            }
            if tableView == decepticonsTableView {
                let transformer = decepticons[indexPath.row]
                detailsVC.transformer = transformer
            }
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
    }
}

extension TransformersViewController: TransformerDelegate {
    
    func addTransformer(_ transformer: Transformer) {
        switch transformer.type {
        case .Autobot:
            autobots.append(transformer)
            autobotsTableView.reloadData()
        case .Decepticon:
            decepticons.append(transformer)
            decepticonsTableView.reloadData()
        }
    }
}
