//
//  PickerViewController.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 5/6/24.
//

import UIKit

class PickerViewController: UIViewController {
    
    var cameraModePicker: UIPickerView!
    let captureModesList = ["Math","Scan","Translate"]
    
    var rotationAngle: CGFloat! = -90  * (.pi/180)
    
    @IBOutlet weak var parentPickerView: UIView!
    
    
    private let horizontalPickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsSelectionIndicator = false
        view.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cameraModePicker = UIPickerView()
//        cameraModePicker.dataSource = self
//        cameraModePicker.delegate = self
//        self.view.addSubview(cameraModePicker)
//        cameraModePicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        
        parentPickerView.addSubview(horizontalPickerView)
        horizontalPickerView.delegate = self
        horizontalPickerView.dataSource = self
        
        
        horizontalPickerView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        horizontalPickerView.heightAnchor.constraint(equalTo: parentPickerView.widthAnchor).isActive = true
        horizontalPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        horizontalPickerView.centerYAnchor.constraint(equalTo: parentPickerView.centerYAnchor, constant: 0).isActive = true
       
    }
    
 
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        cameraModePicker.frame = CGRect(x: parentPickerView.frame.minX, y: parentPickerView.frame.origin.y, width: parentPickerView.bounds.width, height: 100)
//    }
}

extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return captureModesList.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}

extension PickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let modeView = UIView()
        modeView.backgroundColor = .yellow
        
        modeView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let modeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        modeLabel.textColor = .red
        modeLabel.text = captureModesList[row]
        modeLabel.textAlignment = .center
        modeView.addSubview(modeLabel)
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 40, width: 100, height: 60))
        imageView.backgroundColor = UIColor.green
        modeView.addSubview(imageView)
    
      
        // Here the view rotates 90 degree on right side hence we are using positive value.
        modeView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return modeView
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
}
