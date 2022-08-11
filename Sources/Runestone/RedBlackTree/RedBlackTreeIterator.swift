import Foundation

final public class RedBlackTreeIterator<NodeID: RedBlackTreeNodeID, NodeValue: RedBlackTreeNodeValue, NodeData>: IteratorProtocol, LazySequenceProtocol {
    private let tree: RedBlackTree<NodeID, NodeValue, NodeData>
    private var node: RedBlackTreeNode<NodeID, NodeValue, NodeData>?

    public init(tree: RedBlackTree<NodeID, NodeValue, NodeData>) {
        self.tree = tree
        self.node = tree.root.leftMost
    }

    public func next() -> RedBlackTreeNode<NodeID, NodeValue, NodeData>? {
        let currentNode = node
        if let rightNode = node?.right {
            node = rightNode.leftMost
        } else {
            while node?.parent != nil, node == node?.parent?.right {
                node = node?.parent
            }
            node = node?.parent
        }
        return currentNode
    }
}
