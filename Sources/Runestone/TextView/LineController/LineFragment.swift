import CoreText
import Foundation

public struct LineFragmentID: Identifiable, Hashable {
    public let id: String

    public init(lineId: String, lineFragmentIndex: Int) {
        self.id = "\(lineId)[\(lineFragmentIndex)]"
    }
}

extension LineFragmentID: CustomDebugStringConvertible {
    public var debugDescription: String {
        return id
    }
}

public final class LineFragment {
    public let id: LineFragmentID
    public let index: Int
    public let range: NSRange
    public let line: CTLine
    public let descent: CGFloat
    public let baseSize: CGSize
    public let scaledSize: CGSize
    public let yPosition: CGFloat

    public init(id: LineFragmentID, index: Int, range: NSRange, line: CTLine, descent: CGFloat, baseSize: CGSize, scaledSize: CGSize, yPosition: CGFloat) {
        self.id = id
        self.index = index
        self.range = range
        self.line = line
        self.descent = descent
        self.baseSize = baseSize
        self.scaledSize = scaledSize
        self.yPosition = yPosition
    }
}

extension LineFragment: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[LineFragment id=\(id) descent=\(descent) baseSize=\(baseSize) scaledSize=\(scaledSize) yPosition=\(yPosition)]"
    }
}
