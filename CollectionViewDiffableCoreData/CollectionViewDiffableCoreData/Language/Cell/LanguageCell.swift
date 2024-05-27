//
//  LanguageCell.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 25/5/24.
//

import UIKit

class LanguageCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    
    var model: LanguageModel? {
        didSet {
            guard let model = model else { return }
            self.backgroundColor = model.isSelected ? UIColor.red : UIColor.white
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.red : UIColor.white
        }
    }

    
    func foreSelected() {
        
    }
    
}

extension LanguageCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = ""
    }
}
