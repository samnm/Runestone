import TreeSitter

final public class TreeSitterTextRange {
    let rawValue: TSRange
    public var startPoint: TreeSitterTextPoint {
        return TreeSitterTextPoint(row: rawValue.start_point.row, column: rawValue.start_point.column)
    }
    public var endPoint: TreeSitterTextPoint {
        return TreeSitterTextPoint(row: rawValue.end_point.row, column: rawValue.end_point.column)
    }
    public var startByte: ByteCount {
        return ByteCount(rawValue.start_byte)
    }
    public var endByte: ByteCount {
        return ByteCount(rawValue.end_byte)
    }

    public init(startPoint: TreeSitterTextPoint, endPoint: TreeSitterTextPoint, startByte: ByteCount, endByte: ByteCount) {
        self.rawValue = TSRange(
            start_point: startPoint.rawValue,
            end_point: endPoint.rawValue,
            start_byte: UInt32(startByte.value),
            end_byte: UInt32(endByte.value))
    }
}

extension TreeSitterTextRange: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[TreeSitterTextRange startByte=\(startByte) endByte=\(endByte) startPoint=\(startPoint) endPoint=\(endPoint)]"
    }
}
