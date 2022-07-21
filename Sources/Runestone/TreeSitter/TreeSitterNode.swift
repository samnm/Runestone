import TreeSitter
import Foundation

final public class TreeSitterNode {
    let rawValue: TSNode
    public var expressionString: String? {
        if let str = ts_node_string(rawValue) {
            let result = String(cString: str)
            str.deallocate()
            return result
        } else {
            return nil
        }
    }
    public var type: String? {
        if let str = ts_node_type(rawValue) {
            return String(cString: str)
        } else {
            return nil
        }
    }
    public var range: NSRange {
        return NSRange(byteRange)
    }
    var startByte: ByteCount {
        return ByteCount(ts_node_start_byte(rawValue))
    }
    var endByte: ByteCount {
        return ByteCount(ts_node_end_byte(rawValue))
    }
    var startPoint: TreeSitterTextPoint {
        return TreeSitterTextPoint(ts_node_start_point(rawValue))
    }
    var endPoint: TreeSitterTextPoint {
        return TreeSitterTextPoint(ts_node_end_point(rawValue))
    }
    var byteRange: ByteRange {
        return ByteRange(from: startByte, to: endByte)
    }
    public var parent: TreeSitterNode? {
        return getRelationship(using: ts_node_parent)
    }
    public var previousSibling: TreeSitterNode? {
        return getRelationship(using: ts_node_prev_sibling)
    }
    public var nextSibling: TreeSitterNode? {
        return getRelationship(using: ts_node_next_sibling)
    }
    var textRange: TreeSitterTextRange {
        return TreeSitterTextRange(startPoint: startPoint, endPoint: endPoint, startByte: startByte, endByte: endByte)
    }
    public var childCount: Int {
        return Int(ts_node_child_count(rawValue))
    }

    init(node: TSNode) {
        self.rawValue = node
    }

    func descendantForRange(from startPoint: TreeSitterTextPoint, to endPoint: TreeSitterTextPoint) -> TreeSitterNode {
        let node = ts_node_descendant_for_point_range(rawValue, startPoint.rawValue, endPoint.rawValue)
        return TreeSitterNode(node: node)
    }

    public func child(at index: Int) -> TreeSitterNode? {
        if index < childCount {
            let node = ts_node_child(rawValue, UInt32(index))
            return TreeSitterNode(node: node)
        } else {
            return nil
        }
    }
}

private extension TreeSitterNode {
    private func getRelationship(using f: (TSNode) -> TSNode) -> TreeSitterNode? {
        let node = f(rawValue)
        if ts_node_is_null(node) {
            return nil
        } else {
            return TreeSitterNode(node: node)
        }
    }
}

extension TreeSitterNode: Hashable {
    static public func == (lhs: TreeSitterNode, rhs: TreeSitterNode) -> Bool {
        return lhs.rawValue.id == rhs.rawValue.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue.id)
    }
}

extension TreeSitterNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[TreeSitterNode startByte=\(startByte) endByte=\(endByte) startPoint=\(startPoint) endPoint=\(endPoint)]"
    }
}
