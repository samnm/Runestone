import Foundation

final public class RedBlackTreeSearchMatch<NodeID: RedBlackTreeNodeID, NodeValue: RedBlackTreeNodeValue, Data> {
    public typealias Node = RedBlackTreeNode<NodeID, NodeValue, Data>

    public let location: NodeValue
    public let value: NodeValue
    public let node: Node

    public init(location: NodeValue, value: NodeValue, node: Node) {
        self.location = location
        self.value = value
        self.node = node
    }
}
