//
//  ChatViewModel.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 24/5/24.
//

import Foundation
import UIKit

class ChatViewModel {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<ChatViewModel.Section, Item>! = nil
    
    
    func sendMessage(message: String) -> NSDiffableDataSourceSnapshot<ChatViewModel.Section, Item> {
        var snapshot = dataSource.snapshot()
        let newMessage = Item(content: message, chatType: .senderText)
        snapshot.appendItems([newMessage])
        
        return snapshot
    }
}
