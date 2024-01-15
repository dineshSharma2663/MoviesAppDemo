//
//  CommonAppButton.swift
//  
//
//  Created by Dinesh Kumar on 12/01/24.
//

import UIKit

public enum CommonAppButtonType {
    case roundedStandard
}

public final class CommonAppButton: UIButton {
    // Font style property used privately
    private var fontStyle = LBDynamicFontStyle.body
    
    public var buttonLayoutType: CommonAppButtonType = CommonAppButtonType.roundedStandard {
        didSet {
            layer.cornerRadius = 4
            layer.borderWidth = 0
            layer.borderColor = nil
        }
    }
    
    // Font style 'set' & 'get' for use by the client publicly
    public var style: LBDynamicFontStyle {
        get {
            return fontStyle
        } set {
            fontStyle = newValue
            self.titleLabel?.font = LBDynamicFont.fontFromStyle(style: fontStyle)
        }
    }
    
    // MARK: - Initialisation Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        registerForTextChange()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForTextChange()
    }
    
    /// Adding observer to listen the changes made by user to update the font size of the CommonAppButton i.e Dynamic Font Accessibility
    private func registerForTextChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(userChangedTextSize(notification:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    @objc private func userChangedTextSize(notification: Notification) {
        self.titleLabel?.font = LBDynamicFont.fontFromStyle(style: fontStyle)
    }
}
