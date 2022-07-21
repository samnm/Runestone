import TreeSitter

final public class TreeSitterTextPoint {
    public var row: UInt32 {
        return rawValue.row
    }
    public var column: UInt32 {
        return rawValue.column
    }

    let rawValue: TSPoint

    init(_ point: TSPoint) {
        self.rawValue = point
    }

    init(row: UInt32, column: UInt32) {
        self.rawValue = TSPoint(row: row, column: column)
    }
}

extension TreeSitterTextPoint: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[TreeSitterTextPoint row=\(row) column=\(column)]"
    }
}
