import Foundation

final public class RedBlackTreeNodePosition<NodeValue> {
    public let nodeStartLocation: NodeValue
    public let index: Int
    public let offset: NodeValue
    public let value: NodeValue

    public init(nodeStartLocation: NodeValue, index: Int, offset: NodeValue, value: NodeValue) {
        self.nodeStartLocation = nodeStartLocation
        self.index = index
        self.offset = offset
        self.value = value
    }
}
