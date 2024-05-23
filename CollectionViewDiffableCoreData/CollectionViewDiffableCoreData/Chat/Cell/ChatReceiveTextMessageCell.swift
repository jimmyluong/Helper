//
//  ChatReceiveTextMessageCell.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 24/5/24.
//

import UIKit

class ChatReceiveTextMessageCell: UICollectionViewCell {

    @IBOutlet weak var receiveTextLabel: UILabel!
    
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
        receiveTextLabel.text = model.content
    }
}

extension ChatReceiveTextMessageCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetAllValue()
    }
    
    private func resetAllValue() {
        receiveTextLabel.text = ""
    }
}
