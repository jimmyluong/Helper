//
//  ChatSenderImageCell.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 24/5/24.
//

import UIKit

class ChatSenderImageCell: UICollectionViewCell {
    
    @IBOutlet weak var senderImageView: UIImageView!
    
    var model: Item? {
        didSet {
            configCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetAllValue()
    }

    private func configCell() {
        guard let model = model else { return }
        senderImageView.image = UIImage(data: model.image ?? Data())
        senderImageView.backgroundColor = UIColor.red
    }
}


extension ChatSenderImageCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetAllValue()
    }
    
    private func resetAllValue() {
        senderImageView.image = nil
    }
}

