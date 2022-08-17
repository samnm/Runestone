import TreeSitter

final public class TreeSitterInputEdit {
    public let startByte: ByteCount
    public let oldEndByte: ByteCount
    public let newEndByte: ByteCount
    public let startPoint: TreeSitterTextPoint
    public let oldEndPoint: TreeSitterTextPoint
    public let newEndPoint: TreeSitterTextPoint

    public init(startByte: ByteCount,
         oldEndByte: ByteCount,
         newEndByte: ByteCount,
         startPoint: TreeSitterTextPoint,
         oldEndPoint: TreeSitterTextPoint,
         newEndPoint: TreeSitterTextPoint) {
        self.startByte = startByte
        self.oldEndByte = oldEndByte
        self.newEndByte = newEndByte
        self.startPoint = startPoint
        self.oldEndPoint = oldEndPoint
        self.newEndPoint = newEndPoint
    }
}

extension TreeSitterInputEdit: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[TreeSitterInputEdit startByte=\(startByte) oldEndByte=\(oldEndByte) newEndByte=\(newEndByte)"
            + " startPoint=\(startPoint) oldEndPoint=\(oldEndPoint) newEndPoint=\(newEndPoint)]"
    }
}

extension TSInputEdit {
    public init(_ inputEdit: TreeSitterInputEdit) {
        self.init(start_byte: UInt32(inputEdit.startByte.value),
                  old_end_byte: UInt32(inputEdit.oldEndByte.value),
                  new_end_byte: UInt32(inputEdit.newEndByte.value),
                  start_point: inputEdit.startPoint.rawValue,
                  old_end_point: inputEdit.oldEndPoint.rawValue,
                  new_end_point: inputEdit.newEndPoint.rawValue)
    }
}
