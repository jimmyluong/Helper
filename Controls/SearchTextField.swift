

import UIKit

@IBDesignable
class SearchTextField: NahtTextField {
    
    private func updateLeftView() {
        
        let imageSearch = UIImageView(frame: CGRect(x: 18, y: 0, width: 20, height: 20))
        imageSearch.image = #imageLiteral(resourceName: "ic_search")
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 20))
        leftView.addSubview(imageSearch)
            
        self.leftView = leftView

        if text == nil || text == "" {
            self.leftViewMode = .always
        } else {
            self.leftViewMode = .never
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateLeftView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateLeftView()
    }
    
    override func updateControl(_ animated: Bool = false) {
        super.updateControl(animated)
        updateLeftView()
    }
    
}
