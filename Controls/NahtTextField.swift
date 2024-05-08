

import UIKit

class NahtTextField: UITextField {
    
    private var padding: CGFloat = 13
    
    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    private var hasErrorMessage: Bool {
        return errorMessage != nil && errorMessage != ""
    }
    
    /// Description:  TextField required must have min 1 character
    var isRequiredField: Bool = false {
        didSet {
            updateControl()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    
    private func setupUI() {
        self.borderStyle = .none
        cornerRadius = 8
        self.initErrorLabel()
        cornerRadius = 8
        self.addTarget(self, action: #selector(NahtTextField.editingChanged), for: .editingChanged)
    }
    
    @objc
    private func editingChanged() {
        updateControl()
    }
    
    /// Update all change textField
    func updateControl(_ animated: Bool = false) {
        updateErrorLabel()
        updateErrorBorder()
        updateRightView()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        errorLabel.frame = errorLabelRectForBounds(bounds)
    }
    
    override func prepareForInterfaceBuilder() {
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textFieldHeight() + errorLabelHeight())
    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }
    
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateControl(true)
        return result
    }
    
    
    // MARK: Placeholder
    override var placeholder: String? {
        didSet {
            setNeedsDisplay()
            updatePlaceholder()
        }
    }
    
    @objc dynamic open var placeholderFont: UIFont? = UIFont.NotoSansJP(.regular, size: 14) {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable dynamic open var placeholderColor: UIColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1) {
        didSet {
            updatePlaceholder()
        }
    }
    
    private func updatePlaceholder() {
        guard let placeHolder = placeholder, let font = placeholderFont ?? font else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                   attributes: [NSAttributedString.Key.foregroundColor : placeholderColor,
                                                                NSAttributedString.Key.font : font])
    }
    
    //MARK: Right button
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    open func updateRightView() {
        
        /// change clear button
        if let clearButton = self.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(#imageLiteral(resourceName: "ic_clear_text"), for: .normal)
            clearButton.setImage(#imageLiteral(resourceName: "ic_clear_text"), for: .highlighted)
            clearButtonMode = .whileEditing
        }
            
        self.rightView = rightButton

        if text == nil || text == "" {
            self.rightViewMode = .never
        } else {
            self.rightViewMode = .unlessEditing
        }
    }
    
    /// change position clear button
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)

        return originalRect.offsetBy(dx: -5, dy: 0)
    }
    
    
    // MARK: Error Title Label
    private var errorLabel: UILabel!
    
    var errorFont: UIFont = UIFont.NotoSansJP(.bold, size: 14) {
        didSet {
            updateControl()
        }
    }
    
    var errorTextColor: UIColor = #colorLiteral(red: 0.9176470588, green: 0.2235294118, blue: 0.1803921569, alpha: 1) {
        didSet {
            updateControl()
        }
    }
    
    var errorMessage: String? {
        didSet {
            if text == nil || (text ?? "").isEmpty || !hasText {
                if !isRequiredField {
                    errorMessage = nil
                }
            }
            
            updateControl()
        }
    }
    
    private func initErrorLabel() {
        let errorLabel = UILabel()
        errorLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        errorLabel.font = errorFont
        errorLabel.textColor = errorTextColor
        
        addSubview(errorLabel)
        self.errorLabel = errorLabel
    }
    
    private func errorLabelHeight() -> CGFloat {
        guard let errorLabel = errorLabel, let font = errorLabel.font else {
            return 21
        }
        
        return font.lineHeight
    }
    
    private func errorLabelRectForBounds(_ bounds: CGRect, editing: Bool = false) -> CGRect {
        
        let positionY: CGFloat = bounds.maxY + 4
        
        return CGRect(x: 0, y: positionY, width: bounds.size.width, height: errorLabelHeight())
    }
    
    private func updateErrorLabel() {
        guard let errorLabel = errorLabel else {
            return
        }
        
        errorLabel.text = errorMessage
        
    }
    
    private func updateErrorBorder() {
        self.backgroundColor = hasErrorMessage ? #colorLiteral(red: 1, green: 0.9254901961, blue: 0.9215686275, alpha: 1) : #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        self.layer.borderColor = hasErrorMessage ? #colorLiteral(red: 0.9176470588, green: 0.2235294118, blue: 0.1803921569, alpha: 1).cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = hasErrorMessage ? 1 : 0
    }
}

// MARK: TextField
extension NahtTextField {
    
    private func textFieldHeight() -> CGFloat {
        guard let font = self.font else {
            return 21
        }
        
        return font.lineHeight + 24.0
    }
    
    fileprivate func textFieldRectForBounds(_ bounds: CGRect, editing: Bool = false) -> CGRect {
    
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: textFieldHeight())
    }
}

extension NahtTextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        
        let rect = CGRect(x: superRect.origin.x + padding,
                          y: superRect.origin.y,
                          width: superRect.size.width - padding*2,
                          height: superRect.size.height)
        
        return rect
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        
        let rect = CGRect(x: superRect.origin.x + padding,
                          y: superRect.origin.y,
                          width: superRect.size.width - padding*2,
                          height: superRect.size.height)
        
        return rect
    }
}


