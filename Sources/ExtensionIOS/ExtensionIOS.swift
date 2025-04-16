// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import Foundation
@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if UIDevice.current.userInterfaceIdiom == .phone {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    }
    @IBInspectable var iPadCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if UIDevice.current.userInterfaceIdiom == .pad {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return UIColor.clear
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var isCircle: Bool {
        get {
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            if newValue {
                let minDimension = min(bounds.width, bounds.height)
                layer.cornerRadius = minDimension / 2
                layer.masksToBounds = true
            }
        }
    }
}
@IBDesignable
extension UIButton {
    /// Adjusts the corner radius for iPhone devices only
    @IBInspectable var cornerRadiusb: CGFloat {
        get { layer.cornerRadius }
        set {
            if UIDevice.current.userInterfaceIdiom == .phone {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    }
    /// Adjusts the corner radius for iPad devices only
    @IBInspectable var iPadCornerRadiusb: CGFloat {
        get { layer.cornerRadius }
        set {
            if UIDevice.current.userInterfaceIdiom == .pad {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    }
    /// Sets the border width of the button
    @IBInspectable var borderWidthb: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    /// Sets the border color of the button
    @IBInspectable var borderColorb: UIColor {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return UIColor.clear
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    /// Makes the button perfectly circular based on its smallest dimension
    @IBInspectable var isCircleb: Bool {
        get {
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            if newValue {
                let minDimension = min(bounds.width, bounds.height)
                layer.cornerRadius = minDimension / 2
                layer.masksToBounds = true
            }
        }
    }
}
extension UIView {
  public func addShimmer(shimmerColor: UIColor = .white) {
    let dark = shimmerColor.withAlphaComponent(0.2).cgColor
    let light = shimmerColor.withAlphaComponent(0.1).cgColor
    let clear = shimmerColor.withAlphaComponent(0.0).cgColor
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.colors = [clear, light, dark, light, clear]
    gradientLayer.locations = [0, 0.3, 0.5, 0.7, 1]
    layer.addSublayer(gradientLayer)
    self.layer.masksToBounds = true
    let animation = CABasicAnimation(keyPath: "transform.translation.x")
    animation.fromValue = -frame.size.width
    animation.toValue = frame.size.width
    animation.repeatCount = .infinity
    animation.duration = 1.5
    animation.isRemovedOnCompletion = false
    gradientLayer.add(animation, forKey: animation.keyPath)
  }
}
@IBDesignable
extension UILabel {
    @IBInspectable var fontName: String? {
        get {
            return self.font.fontName
        }
        set {
            if let fontName = newValue, let fontSize = self.font?.pointSize {
                self.font = UIFont(name: fontName, size: fontSize)
            }
        }
    }
    @IBInspectable var fontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if UIDevice.current.userInterfaceIdiom == .phone {
                setFontSize(newValue)
            }
        }
    }
    @IBInspectable var iPadFontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if UIDevice.current.userInterfaceIdiom == .pad {
                setFontSize(newValue)
            }
        }
    }
    private func setFontSize(_ size: CGFloat) {
        if let fontName = self.font?.fontName {
            self.font = UIFont(name: fontName, size: size)
        }
    }
}
@IBDesignable
public class GradientView: UIView {
    // MARK: - Inspectable Properties
    @IBInspectable var hexColors: String = "#FFFFFF,#000000" {
        didSet { updateGradient() }
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet { updateGradient() }
    }
    private let gradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    private func sharedInit() {
        layer.insertSublayer(gradientLayer, at: 0)
        updateGradient()
    }
    // MARK: - Gradient Update
    private func updateGradient() {
        gradientLayer.colors = parseHexColors(hexColors).map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = isHorizontal ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
    }
    // MARK: - Hex Parser
    private func parseHexColors(_ hexString: String) -> [UIColor] {
        return hexString
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { UIColor(hex: $0) }
    }
}
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        // Handle shorthand (#RGB)
        if hexSanitized.count == 3 {
            let r = hexSanitized[hexSanitized.startIndex]
            let g = hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 1)]
            let b = hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 2)]
            hexSanitized = "\(r)\(r)\(g)\(g)\(b)\(b)"
        }

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        switch hexSanitized.count {
        case 6:
            self.init(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        case 8:
            self.init(
                red: CGFloat((rgb & 0xFF000000) >> 24) / 255.0,
                green: CGFloat((rgb & 0x00FF0000) >> 16) / 255.0,
                blue: CGFloat((rgb & 0x0000FF00) >> 8) / 255.0,
                alpha: CGFloat(rgb & 0x000000FF) / 255.0
            )
        default:
            return nil
        }
    }
}
@IBDesignable
public class GradientButton: UIButton {
    // MARK: - Inspectable Properties
    @IBInspectable var hexColors: String = "#FFFFFF,#000000" {
        didSet { updateGradient() }
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet { updateGradient() }
    }
    private let gradientLayer = CAGradientLayer()
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    // MARK: - Setup
    private func sharedInit() {
        clipsToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
        updateGradient()
    }
    // MARK: - Gradient Update
    private func updateGradient() {
        gradientLayer.colors = parseHexColors(hexColors).map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = isHorizontal ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
    }
    // MARK: - Hex Parser
    private func parseHexColors(_ hexString: String) -> [UIColor] {
        return hexString
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { UIColor(hex: $0) }
    }
}

