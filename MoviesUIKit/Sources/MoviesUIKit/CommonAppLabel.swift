
import UIKit

/// Enum used to define different text Font styles used in the application at centralised place.
/// So that client provides the 'LBDynamicFontStyle' case, then after all font size, weight calcuation are done based on this style.
/// It can be used with Label, Textfields & any other Text views having using text & need font styling.
public enum LBDynamicFontStyle {
    case title1
    case subHeader
    case body
    case headline
    case cellLabel
    
    var defaultFontSize: CGFloat {
        switch self {
        case .title1:
            return 15
        case .subHeader:
            return 14
        case .body:
            return 13
        case .headline:
            return 14
        case .cellLabel:
            return 13
        }
    }
    
    var weight: String {
        switch self {
        case .title1:
            return "Medium"
        case .subHeader:
            return "Regular"
        case .body:
            return "Regular"
        case .headline:
            return "Italic"
        case .cellLabel:
            return "Regular"
        }
    }
}

/// CommonAppLabel is custom UILabel subclass used to design the label used in the application where all common properties of all labels can be managed & configured like dynamic font, style text color etc. so that we dont need to change through out the application when application grows.
public final class CommonAppLabel: UILabel {
    
    // Font style property used privately
    private var fontStyle = LBDynamicFontStyle.body
    
    // Font style 'set' & 'get' for use by the client publicly
    public var style: LBDynamicFontStyle {
        get {
            return fontStyle
        } set {
            fontStyle = newValue
            self.font = LBDynamicFont.fontFromStyle(style: fontStyle)
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
    
    /// Adding observer to listen the changes made by user to update the font size of the lable i.e Dynamic Font Accessibility
    private func registerForTextChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(userChangedTextSize(notification:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    @objc private func userChangedTextSize(notification: Notification) {
        self.font = LBDynamicFont.fontFromStyle(style: fontStyle)
    }
}

public final class LBDynamicFont {
    
    // Percentage change in font size in a single step shift in content size category
    private static let fontChangePerStep: CGFloat = 1.6

    /// This function will provide the multiple by which the default font will be multiplied to get the scaled font.
    /// - Returns: font scale multiple
    private static func getScaledFontMultiple() -> CGFloat {
        switch UIApplication.shared.preferredContentSizeCategory {
        case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return 1 + (pow(fontChangePerStep, 8) / 100)
        case UIContentSizeCategory.accessibilityExtraExtraLarge:
            return 1 + (pow(fontChangePerStep, 7) / 100)
        case UIContentSizeCategory.accessibilityExtraLarge:
            return 1 + (pow(fontChangePerStep, 6) / 100)
        case UIContentSizeCategory.accessibilityLarge:
            return 1 + (pow(fontChangePerStep, 5) / 100)
        case UIContentSizeCategory.accessibilityMedium:
            return 1 + (pow(fontChangePerStep, 4) / 100)
        case UIContentSizeCategory.extraExtraExtraLarge:
            return 1 + (pow(fontChangePerStep, 3) / 100)
        case UIContentSizeCategory.extraExtraLarge:
            return 1 + (pow(fontChangePerStep, 2) / 100)
        case UIContentSizeCategory.extraLarge:
            return 1 + (pow(fontChangePerStep, 1) / 100)
        case UIContentSizeCategory.large:
            return 1.0
        case UIContentSizeCategory.medium:
            return 1 - (pow(fontChangePerStep, 1) / 100)
        case UIContentSizeCategory.small:
            return 1 - (pow(fontChangePerStep, 2) / 100)
        case UIContentSizeCategory.extraSmall:
            return 1 - (pow(fontChangePerStep, 3) / 100)
        default:
            return 1
        }
    }
    
    /// This function returns the dynamic AvenirNext font of provided font size & weight of the font.
    /// - Parameters:
    ///   - size: font size of the required UIFont
    ///   - weight: weight of the font i.e like Regular, Medium, Bol etc
    /// - Returns: UIFont object
    public static func avenirNextFont(for size: CGFloat, weight: String) -> UIFont {
        return UIFont(name: "AvenirNext-\(weight)", size: scaledFontSize(for: size)) ?? .systemFont(ofSize: size)
    }
    
    /// This function returns the dynamic UIFont object based on LBDynamicFontStyle information
    /// - Parameter style: provided font style
    /// - Returns: UIFont object returned
    static func fontFromStyle(style: LBDynamicFontStyle) -> UIFont {
        let fontToScale: UIFont = UIFont(name: "AvenirNext-\(style.weight)", size: scaledFontSize(for: style.defaultFontSize)) ?? .systemFont(ofSize: style.defaultFontSize)
        return fontToScale
    }
    
    /// This function scaled up/down the provided font size based on preferredContentSizeCategory
    /// - Parameter fontSize: provided font size to be scaled based on preferredContentSizeCategory
    /// - Returns: scaled font size
    public static func scaledFontSize(for fontSize: CGFloat) -> CGFloat {
        let scalingMuliple = getScaledFontMultiple()
        let scaledFontSize = fontSize * scalingMuliple
        return scaledFontSize
    }
}

