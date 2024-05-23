//
//  ChatSenderTextMessageCell.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 24/5/24.
//

import UIKit

class ChatSenderTextMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var senderTextLabel: UILabel!
    
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
        senderTextLabel.text = model.content
    }

}

extension ChatSenderTextMessageCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetAllValue()
    }
    
    private func resetAllValue() {
        senderTextLabel.text = ""
    }
}

