

import UIKit

class IntrinsicTableView: UITableView {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    override func prepareForInterfaceBuilder() {
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        
        guard let _dataSource = self.dataSource else {
            return super.intrinsicContentSize
        }
        /// Variale height:
        var height: CGFloat = tableHeaderView?.intrinsicContentSize.height ?? 0
        
        if let footer = tableFooterView {
            height += footer.intrinsicContentSize.height
        }
        
        let _sections = _dataSource.numberOfSections?(in: self) ?? self.numberOfSections
        
        for section in 0..<_sections {
            let headerSection = rectForHeader(inSection: section)
            height += headerSection.height
            
            let footerSection = rectForFooter(inSection: section)
            height += footerSection.height
            
            let rowSection = self.numberOfRows(inSection: section)
            for row in 0..<rowSection {
                height += self.rectForRow(at: IndexPath(row: row, section: section)).size.height
            }
        }
        Logger.debug("IntrinsicTableView: section: \(_sections) --> height: \(height)")
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}
