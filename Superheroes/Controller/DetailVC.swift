//
//  DetailVC.swift
//  Superheroes
//
//  Created by Michael Tseitlin on 4/11/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var superHero: SuperHero!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var intelligenceLabel: UILabel!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var durabilityLabel: UILabel!
    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var combatLabel: UILabel!
    
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var raceLabel: UILabel!
    @IBOutlet var heightByCm: UILabel!
    @IBOutlet var weightByKg: UILabel!
    
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var alterEgosLabel: UILabel!
    @IBOutlet var aliasesLabel: UILabel!
    @IBOutlet var firstAppearanceLabel: UILabel!
    @IBOutlet var publisherLabel: UILabel!
    @IBOutlet var alignmentLabel: UILabel!
    
    @IBOutlet var occupationLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchImage()
        createStats()
        
    }
    
    private func fetchImage() {

        DispatchQueue.global().async {
            guard let imageURL = URL(string: self.superHero.images!.lg) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.detailImage.layer.cornerRadius = 15
                self.detailImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func createStats() {
        
        nameLabel.text = "Name is \(superHero.name ?? "Unknown")"
        
        guard let powerstats = superHero.powerstats else { return  }
        
        intelligenceLabel.text = "INTELLIGENCE: \(String(powerstats.intelligence))"
        strengthLabel.text = "STRENGTH: \(String(powerstats.strength))"
        speedLabel.text = "SPEED: \(String(powerstats.speed))"
        durabilityLabel.text = "DURABILTY: \(String(powerstats.durability))"
        powerLabel.text = "POWER: \(String(powerstats.power))"
        combatLabel.text = "COMBAT: \(String(powerstats.combat))"

        guard let appearance = superHero.appearance else { return }
        
        genderLabel.text = "GENDER: \(appearance.gender)"
        raceLabel.text = "RACE: \(String(appearance.race ?? "Unknown"))"
        heightByCm.text = "\(appearance.height[1])"
        weightByKg.text = "\(appearance.weight[1])"

        guard let biography = superHero.biography else { return  }
        
        fullNameLabel.text = "FULL NAME: \(biography.fullName)"
        alterEgosLabel.text = "ALTER EGOS: \(biography.alterEgos)"
        aliasesLabel.text = "ALIASES: \(biography.aliases)"
        firstAppearanceLabel.text = "FIRST APPEARANCE: \(biography.firstAppearance)"
        publisherLabel.text = "PUBLISHER: \(String(biography.publisher ?? "Unknown"))"
        alignmentLabel.text = "ALIGNMENT: \(biography.alignment)"

        guard let work = superHero.work else { return  }
        
        occupationLabel.text = "OCCUPATION: \(work.occupation)"
        baseLabel.text = "BASE: \(work.base)"

    }
    
}
