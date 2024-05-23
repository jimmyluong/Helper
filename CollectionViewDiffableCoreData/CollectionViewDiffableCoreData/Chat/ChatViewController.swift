//
//  ChatViewController.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 23/5/24.
//

import UIKit
import IQKeyboardManagerSwift

enum ChatMessageType: CaseIterable {
    case senderText
    case senderImage
    case receive
}

struct Item: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    var content: String?
    var image: Data?
    
    var chatType: ChatMessageType
}

class ChatViewController: UIViewController {
    
    @IBOutlet weak var inputWrapView: UIView!
    @IBOutlet weak var growingTextView: GrowingTextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ChatViewModel()
    
    var count: Int = 0
    let listText: [String?] = ["The runTimedCode selector", nil,
                              "Important note: because your object has a property to store the timer",
                              "Important note: because your object has a property to store the timer, and the timer calls a method on the object, you have a strong reference cycle that means neither object can be freed. To fix this, make sure you invalidate the timer when you're done with it, such as when your view is about to disappear:",
                              "My problem is that I cannot figure out how to reload a section in the collection view with a new set of items without appending them to the current ones. The methods available to the snapshot only allow for items to be appended to the section, but I need the items of the section to be replaced. I have tried deleting the section, appending it back then appending the new set of items:",
    "Ông Tập cùng ông Putin ngày 16/5 đi dạo dưới hàng liễu tại Trung Nam Hải, trụ sở đảng Cộng sản Trung Quốc và Quốc vụ viện. Đây là quần thể cung điện cổ kính xây dựng từ thời nhà Kim vào thế kỷ 12, là nơi nhiều lãnh đạo Trung Quốc sống và làm việc từ sau năm 1949. \n Phái đoàn Nga gồm Ngoại trưởng Sergey Lavrov, Bộ trưởng Quốc phòng Andrey Belousov, Thư ký Hội đồng An ninh Sergey Shoigu và Trợ lý Tổng thống Yury Ushakov. Phía Trung Quốc có Ngoại trưởng Vương Nghị, Bí thư Ban Bí thư đảng Cộng sản Trung Quốc Thái Kỳ và các quan chức khác. \n ổng thống Nga Putin thăm cấp nhà nước Trung Quốc ngày 16-17/5, đánh dấu chuyến thăm nước ngoài đầu tiên của ông kể từ khi nhậm chức nhiệm kỳ 5 ngày 7/5. Ông Putin và ông Tập ngày 16/5 đã hội đàm và ký kết tuyên bố chung về làm sâu sắc quan hệ đối tác chiến lược toàn diện trong hợp tác vì kỷ nguyên mới. Nga thông báo hai nước sẽ sớm ký kết hợp đồng xây dựng đường ống khí đốt Power of Siberia 2 sau nhiều năm đàm phán", "aaa", " thân thiết trong", "quốc gia và hai nhà lãnh đạo, mà còn thể hiện cho Washington thấy thái độ của Trung Quốc trong bối cảnh Mỹ đang gây áp lực để khiến Bắc Kinh ngừng ủng hộ Moskva, Richard McGregor, ng"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1),
                                                         .font: UIFont.systemFont(ofSize: 14)]
        self.growingTextView.attributedPlaceholder = NSAttributedString(string: "test", attributes: attributes)
        
        configureHierarchy()
        configureDataSource()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            if self?.count ?? 0 < 100 {
                self?.testAddElement()
                self?.count += 1
            }
        }
    }
    
    private func testAddElement() {
        
        let text = listText.randomElement()

        let model: Item
        
        if self.count % 3 == 0 {
            model = Item(image: Data(), chatType: .senderImage)
        } else {
            model = Item(content: text ?? "AAAA", image: nil, chatType: .receive)
        }
        
        var snapshot = self.viewModel.dataSource.snapshot()
        snapshot.appendItems([model], toSection: .main)
        viewModel.dataSource.applySnapshotUsingReloadData(snapshot) {
            print("Reload Done")
            DispatchQueue.main.async {
                self.collectionView.scrollToBottom(animated: false)
            }
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let snapshot = viewModel.sendMessage(message: growingTextView.text)
        viewModel.dataSource.applySnapshotUsingReloadData(snapshot) { [weak self] in
            self?.collectionView.scrollToBottom(animated: true)
        }
        
        growingTextView.text = ""
    }
    
}

extension ChatViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
//        collectionView.delegate = self
    }
    
    /// - Tag: CellRegistration
    private func configureDataSource() {
        let chatSenderTextNib = UINib(nibName: "ChatSenderTextMessageCell", bundle: nil)
        let chatSenderTextCell = UICollectionView.CellRegistration<ChatSenderTextMessageCell, Item>(cellNib: chatSenderTextNib) { cell, indexPath, itemIdentifier in
            cell.model = itemIdentifier
        }
        
        let chatSenderImageNib = UINib(nibName: "ChatSenderImageCell", bundle: nil)
        let chatSenderImageCell = UICollectionView.CellRegistration<ChatSenderImageCell, Item>(cellNib: chatSenderImageNib) { cell, indexPath, itemIdentifier in
            cell.model = itemIdentifier
        }
        
        let chatReceiveTextNib = UINib(nibName: "ChatReceiveTextMessageCell", bundle: nil)
        let chatReceiveTextCell = UICollectionView.CellRegistration<ChatReceiveTextMessageCell, Item>(cellNib: chatReceiveTextNib) { cell, indexPath, itemIdentifier in
            cell.model = itemIdentifier
        }
        
        viewModel.dataSource = UICollectionViewDiffableDataSource<ChatViewModel.Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            switch item.chatType {
            case .senderText:
                return collectionView.dequeueConfiguredReusableCell(using: chatSenderTextCell, for: indexPath, item: item)
            case .senderImage:
                return collectionView.dequeueConfiguredReusableCell(using: chatSenderImageCell, for: indexPath, item: item)
            case .receive:
                return collectionView.dequeueConfiguredReusableCell(using: chatReceiveTextCell, for: indexPath, item: item)
            }
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<ChatViewModel.Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([])
        viewModel.dataSource.apply(snapshot, animatingDifferences: false)
    }
}


extension UICollectionView {

    // MARK: - UICollectionView scrolling/datasource

    /// Last Section of the CollectionView
    var lastSection: Int {
        return numberOfSections - 1
    }

    /// IndexPath of the last item in last section.
    var lastIndexPath: IndexPath? {
        guard lastSection >= 0 else {
            return nil
        }

        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else {
            return nil
        }

        return IndexPath(item: lastItem, section: lastSection)
    }

    /// Islands: Scroll to bottom of the CollectionView
    /// by scrolling to the last item in CollectionView
    func scrollToBottom(animated: Bool) {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        scrollToItem(at: lastIndexPath, at: .bottom, animated: animated)
    }
}
