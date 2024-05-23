//
//  ViewController.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 21/5/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(identifier: "ChatViewController") as? ChatViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

