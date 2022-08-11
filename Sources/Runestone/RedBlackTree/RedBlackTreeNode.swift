import Foundation

public protocol RedBlackTreeNodeID: Identifiable, Hashable {
    init()
}

public typealias RedBlackTreeNodeValue = Comparable & AdditiveArithmetic

final public class RedBlackTreeNode<NodeID: RedBlackTreeNodeID, NodeValue: RedBlackTreeNodeValue, NodeData> {
    public typealias Tree = RedBlackTree<NodeID, NodeValue, NodeData>

    public let id = NodeID()
    public internal(set) var nodeTotalValue: NodeValue
    public internal(set) var nodeTotalCount: Int
    public var location: NodeValue {
        return tree.location(of: self)
    }
    public var value: NodeValue
    public var index: Int {
        return tree.index(of: self)
    }
    public internal(set) var left: RedBlackTreeNode?
    public internal(set) var right: RedBlackTreeNode?
    public internal(set) weak var parent: RedBlackTreeNode?
    public internal(set) var color: RedBlackTreeNodeColor = .black
    public let data: NodeData
    public var tree: Tree {
        if let tree = _tree {
            return tree
        } else {
            fatalError("Accessing tree after it has been deallocated.")
        }
    }

    private weak var _tree: Tree?

    public init(tree: Tree, value: NodeValue, data: NodeData) {
        self._tree = tree
        self.nodeTotalCount = 1
        self.nodeTotalValue = value
        self.value = value
        self.data = data
    }
}

extension RedBlackTreeNode {
    public var leftMost: RedBlackTreeNode {
        var node = self
        while let newNode = node.left {
            node = newNode
        }
        return node
    }
    public var rightMost: RedBlackTreeNode {
        var node = self
        while let newNode = node.right {
            node = newNode
        }
        return node
    }
    public var previous: RedBlackTreeNode {
        if let left = left {
            return left.rightMost
        } else {
            var oldNode = self
            var node = parent ?? self
            while let parent = node.parent, node.left === oldNode {
                oldNode = node
                node = parent
            }
            return node
        }
    }
    public var next: RedBlackTreeNode {
        if let right = right {
            return right.leftMost
        } else {
            var oldNode = self
            var node = parent ?? self
            while let parent = node.parent, node.right === oldNode {
                oldNode = node
                node = parent
            }
            return node
        }
    }
}

extension RedBlackTreeNode: Hashable {
    public static func == (lhs: RedBlackTreeNode<NodeID, NodeValue, NodeData>, rhs: RedBlackTreeNode<NodeID, NodeValue, NodeData>) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension RedBlackTreeNode where NodeData == Void {
    public convenience init(tree: Tree, value: NodeValue) {
        self.init(tree: tree, value: value, data: ())
    }
}

extension RedBlackTreeNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[RedBlackTreeNode index=\(index) location=\(location) nodeTotalCount=\(nodeTotalCount)]"
    }
}
