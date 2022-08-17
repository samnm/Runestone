import Foundation

public final class LinePosition: Hashable, Equatable {
    public let row: Int
    public let column: Int

    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }

    public convenience init(_ point: TreeSitterTextPoint) {
        let row = Int(point.row)
        let column = Int(point.column / 2)
        self.init(row: row, column: column)
    }

    public static func == (lhs: LinePosition, rhs: LinePosition) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
    }
}

extension LinePosition: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[LinePosition row=\(row) column=\(column)]"
    }
}
