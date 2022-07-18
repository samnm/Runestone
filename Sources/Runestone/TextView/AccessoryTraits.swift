import UIKit
import Foundation

public struct AccessoryTraits {
    public let attachment: String
    public let color: UIColor

    public init(attachment: String, color: UIColor) {
        self.attachment = attachment
        self.color = color
    }
}

extension AccessoryTraits: Codable {
    enum CodingKeys: String, CodingKey {
        case attachment
        case red
        case green
        case blue
        case alpha
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attachment = try values.decode(String.self, forKey: .attachment)

        let red = try values.decode(CGFloat.self, forKey: .red)
        let green = try values.decode(CGFloat.self, forKey: .green)
        let blue = try values.decode(CGFloat.self, forKey: .blue)
        let alpha = try values.decode(CGFloat.self, forKey: .alpha)
        color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    public func encode(to encoder: Encoder) throws {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(attachment, forKey: .attachment)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(alpha, forKey: .alpha)
    }
}
