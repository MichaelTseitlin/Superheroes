//
//  SuperHero.swift
//  Superheroes
//
//  Created by Michael Tseitlin on 4/9/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import Foundation

struct SuperHero: Decodable {
    
    let name: String?
    let powerstats: PowerStats?
    let appearance: Appearance?
    let biography: Biography?
    let work: Work?
    let images: Images?
    
    init(dict: [String : Any]) {
        let nameValue = dict["name"] as! String
        
        let powerStats = dict["powerstats"] as! [String : Int]
        let powerstatsValue = PowerStats(intelligence: powerStats["intelligence"]!,
                                  strength: powerStats["strength"]!,
                                  speed: powerStats["speed"]!,
                                  durability: powerStats["durability"]!,
                                  power: powerStats["power"]!,
                                  combat: powerStats["combat"]!)
        
        let appearStats = dict["appearance"] as! [String : Any]
        let appearanceValue = Appearance(gender: Gender(rawValue: ((appearStats["gender"] as? String)!))!,
                                     race: appearStats["race"] as? String,
                                     height: (appearStats["height"] as? [String])!,
                                     weight: (appearStats["weight"] as? [String])!)
        
        let bioStats = dict["biography"] as! [String : Any]
        let biographyValue = Biography(fullName: bioStats["fullName"] as! String,
                                    alterEgos: bioStats["alterEgos"] as! String,
                                    aliases: (bioStats["aliases"] as? [String])!,
                                    firstAppearance: bioStats["firstAppearance"] as! String,
                                    publisher: bioStats["publisher"] as? String,
                                    alignment: Alignment(rawValue: bioStats["alignment"] as! String)!)
        
        let workStats = dict["work"] as! [String : String]
        let workValue = Work(occupation: workStats["occupation"]!,
                             base: workStats["base"]!)
        
        let imgStats = dict["images"] as! [String : String]
        let imagesValue = Images(xs: imgStats["xs"]!,
                                 sm: imgStats["sm"]!,
                                 md: imgStats["md"]!,
                                 lg: imgStats["lg"]!)
        
        let name = nameValue
        let powerstats = powerstatsValue
        let appearance = appearanceValue
        let biography = biographyValue
        let work = workValue
        let images = imagesValue
        
        self.name = name
        self.powerstats = powerstats
        self.appearance = appearance
        self.biography = biography
        self.work = work
        self.images = images
    }
    
    static func getArray(from arrayOfItems: Any) -> [SuperHero]? {
        guard let arrayOfSuperHeroes = arrayOfItems as? Array<[String : Any]> else { return nil }
        return arrayOfSuperHeroes.compactMap { SuperHero(dict: $0)}
    }
}

struct PowerStats: Decodable {
    
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Appearance: Codable {
    
    let gender: Gender
    let race: String?
    let height, weight: [String]
}

enum Gender: String, Codable {
    
    case empty = "-"
    case female = "Female"
    case male = "Male"
}

struct Biography: Codable {
    
    let fullName, alterEgos: String
    let aliases: [String]
    let firstAppearance: String
    let publisher: String?
    let alignment: Alignment
}

enum Alignment: String, Codable {
    
    case bad = "bad"
    case empty = "-"
    case good = "good"
    case neutral = "neutral"
}

struct Work: Codable {
    
    let occupation, base: String
}

struct Images: Decodable {
    
    let xs: String
    let sm: String
    let md: String
    let lg: String
}

