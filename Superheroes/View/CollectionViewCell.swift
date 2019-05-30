//
//  CollectionViewCell.swift
//  Superheroes
//
//  Created by Michael Tseitlin on 4/9/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    
    func configureCell(superHero: SuperHero) {
        
        mainLabel.text = superHero.name
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: superHero.images!.sm) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.mainImage.layer.cornerRadius = 15
                self.mainImage.image = UIImage(data: imageData)
            }
        }
        
    }
}
