import UIKit

final class TreeSitterSyntaxHighlightToken {
    let range: NSRange
    let textColor: UIColor?
    let shadow: NSShadow?
    let font: UIFont?
    let accessory: String?
    let fontTraits: FontTraits
    var isEmpty: Bool {
        return range.length == 0 || (textColor == nil && font == nil && shadow == nil)
    }

    init(range: NSRange, textColor: UIColor?, shadow: NSShadow?, font: UIFont?, fontTraits: FontTraits, accessory: String?) {
        self.range = range
        self.textColor = textColor
        self.shadow = shadow
        self.font = font
        self.fontTraits = fontTraits
        self.accessory = accessory
    }
}

extension TreeSitterSyntaxHighlightToken: Equatable {
    static func == (lhs: TreeSitterSyntaxHighlightToken, rhs: TreeSitterSyntaxHighlightToken) -> Bool {
        return lhs.range == rhs.range && lhs.textColor == rhs.textColor && lhs.font == rhs.font
    }
}

extension TreeSitterSyntaxHighlightToken {
    static func locationSort(_ lhs: TreeSitterSyntaxHighlightToken, _ rhs: TreeSitterSyntaxHighlightToken) -> Bool {
        if lhs.range.location != rhs.range.location {
            return lhs.range.location < rhs.range.location
        } else {
            return lhs.range.length < rhs.range.length
        }
    }
}

extension TreeSitterSyntaxHighlightToken: CustomDebugStringConvertible {
    var debugDescription: String {
        return "[TreeSitterSyntaxHighlightToken: \(range.location) - \(range.length)]"
    }
}
