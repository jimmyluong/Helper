//
//  ViewController.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 21/5/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        mainButton.setTitle(AMPLocalizeUtils.defaultLocalizer.stringForKey(key: "language_vi"), for: .normal)
        mainButton.setTitle(L10n.pauseMessge, for: .normal)
    }

    @IBAction func pushAction(_ sender: Any) {
//        guard let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(identifier: "ChatViewController") as? ChatViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LanguageViewController") as? LanguageViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PickerViewController") as? PickerViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

