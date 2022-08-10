import Foundation

final public class ClosedRangeValueSearchQuery<NodeID: RedBlackTreeNodeID, NodeValue: RedBlackTreeNodeValue, NodeData>: RedBlackTreeSearchQuery {
    private let range: ClosedRange<NodeValue>
    private var cachedNodeLocations: [NodeID: NodeValue] = [:]

    public init(range: ClosedRange<NodeValue>) {
        self.range = range
    }

    public func shouldTraverseLeftChildren(of node: RedBlackTreeNode<NodeID, NodeValue, NodeData>) -> Bool {
        return location(of: node) > range.upperBound
    }

    public func shouldTraverseRightChildren(of node: RedBlackTreeNode<NodeID, NodeValue, NodeData>) -> Bool {
        return location(of: node) + node.value < range.upperBound
    }

    public func shouldInclude(_ node: RedBlackTreeNode<NodeID, NodeValue, NodeData>) -> Bool {
        let nodeLowerBound = location(of: node)
        let nodeUpperBound = nodeLowerBound + node.value
        return nodeLowerBound <= range.upperBound && range.lowerBound <= nodeUpperBound
    }
}

private extension ClosedRangeValueSearchQuery {
    private func location(of node: RedBlackTreeNode<NodeID, NodeValue, NodeData>) -> NodeValue {
        if let cachedLocation = cachedNodeLocations[node.id] {
            return cachedLocation
        } else {
            let location = node.location
            cachedNodeLocations[node.id] = location
            return location
        }
    }
}
