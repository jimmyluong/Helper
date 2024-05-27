//
//  LanguageViewController.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 24/5/24.
//

import UIKit
//import LanguageManager_iOS

enum LanguageType {
    case en
    case vi
    case korean
    
    var key: String {
        switch self {
        case .en:
            return "en"
        case .vi:
            return "vi"
        case .korean:
            return "ko"
        }
    }
    
    var title: String {
//        switch self {
//        case .en:
//            return "language_en".localiz()
//        case .vi:
//            return "language_vi".localiz()
//        case .korean:
//            return "language_ko".localiz()
//        }
        switch self {
        case .en:
            return AMPLocalizeUtils.defaultLocalizer.stringForKey(key: "language_en")
        case .vi:
            return AMPLocalizeUtils.defaultLocalizer.stringForKey(key: "language_vi")
        case .korean:
            return AMPLocalizeUtils.defaultLocalizer.stringForKey(key: "language_ko")
        }
        
//        switch self {
//        case .en:
//            return TestLocalized.shared.localized(key: "language_en")
//        case .vi:
//            return  TestLocalized.shared.localized(key: "language_vi")
//        case .korean:
//            return  TestLocalized.shared.localized(key: "language_ko")
//        }
    }
    
    var icon: UIImage {
        return UIImage()
    }
}

struct LanguageModel: Hashable {
    
    var id: String
    
    var title: String
    var icon: UIImage
    
    var type: LanguageType?
    
    var isSelected: Bool
    
    init(type: LanguageType, id: String = UUID().uuidString, isSelected: Bool) {
        self.title = type.title
        self.icon = type.icon
        self.type = type
        self.id = id
        self.isSelected = isSelected
    }
}

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, LanguageModel>! = nil
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    enum Section {
        case main
    }

    var languages = [LanguageModel(type: .en, isSelected: false),
                     LanguageModel(type: .vi, isSelected: false),
                     LanguageModel(type: .korean, isSelected: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(reload))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }

    @objc func reload() {
        var snapshot = self.dataSource.snapshot()

        var newSnapShot = NSDiffableDataSourceSnapshot<Section, LanguageModel>()
        newSnapShot.appendSections([.main])
        newSnapShot.appendItems(languages)
//        let matchData = languages.map { LanguageModel(type: $0.type ?? .en, id: UUID().uuidString, isSelected: $0.isSelected)}
//        newSnapShot.appendItems(matchData)
        
//        dataSource.apply(newSnapShot)
        
        dataSource.applySnapshotUsingReloadData(newSnapShot)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        languages[1].isSelected = true
//        reload()
    }
}

extension LanguageViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
//        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        
        let nib = UINib(nibName: "LanguageCell", bundle: nil)
        let cellRegistration = UICollectionView.CellRegistration<LanguageCell, LanguageModel>(cellNib: nib) { cell, indexPath, itemIdentifier in
            cell.model = itemIdentifier
            cell.textLabel.text = itemIdentifier.title
        }
        
        
        dataSource = UICollectionViewDiffableDataSource<Section, LanguageModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: LanguageModel) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, LanguageModel>()
        snapshot.appendSections([.main])
        
//        let languages = [LanguageModel(title: "EN", icon: UIImage()),
//                         LanguageModel(title: "VN", icon: UIImage()),
//                         LanguageModel(title: "EU", icon: UIImage()),
//                         LanguageModel(title: "FR", icon: UIImage())]
        
        
        snapshot.appendItems(languages)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension LanguageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        for (index, element) in languages.enumerated() {
            
            var newValue = indexPath.item == index ? true : false
            
            languages[index].isSelected = newValue
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var model = self.dataSource.itemIdentifier(for: indexPath) else {
//            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        
        
        let index = self.dataSource.indexPath(for: model)
        
        
        
        
        
        defaultLocalizer.setSelectedLanguage(lang: (model.type ?? .en).key)
//        reload()
       
//        var selectedLanguage: Languages
//        
//        switch model.type! {
//        case .en:
//            selectedLanguage = .en
//        case .vi:
//            selectedLanguage = .vi
//        case .korean:
//            selectedLanguage = .ko
//        }
//        
//        LanguageManager.shared.setLanguage(language: selectedLanguage)
       
        
//        let snapshot = self.dataSource.snapshot()
//        self.dataSource.applySnapshotUsingReloadData(snapshot) {
//            
//            print("Reload")
//        }
    }
}


class AMPLocalizeUtils: NSObject {

    static let defaultLocalizer = AMPLocalizeUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            appbundle = Bundle.main
            return
        }
        appbundle = Bundle(path: langPath)!
    }
    
    func stringForKey(key: String) -> String {
        return appbundle.localizedString(forKey: key, value: "", table: nil)
    }
}

extension String {
    
    var localized: String {
        let languageCode = Bundle.main.preferredLocalizations.first ?? "en"
        let resourceBundle = Bundle.main.path(forResource: languageCode, ofType: "lproj") ?? "en"
        
        return NSLocalizedString(self, bundle: Bundle(path: resourceBundle) ?? Bundle.main, comment: self)
    }
    
    func localizedWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
    
    
}
