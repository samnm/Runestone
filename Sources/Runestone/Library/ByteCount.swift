import Foundation

public struct ByteCount: Hashable {
    private(set) public var value: Int
    public var utf16Length: Int {
        return value / 2
    }

    public init(_ value: Int) {
        self.value = value
    }

    public init(_ value: UInt32) {
        self.value = Int(value)
    }

    public init(utf16Length: Int) {
        self.value = utf16Length * 2
    }
}

extension ByteCount: Comparable {
    static public func < (lhs: ByteCount, rhs: ByteCount) -> Bool {
        return lhs.value < rhs.value
    }

    static public func <= (lhs: ByteCount, rhs: ByteCount) -> Bool {
        return lhs.value <= rhs.value
    }

    static public func >= (lhs: ByteCount, rhs: ByteCount) -> Bool {
        return lhs.value >= rhs.value
    }

    static public func > (lhs: ByteCount, rhs: ByteCount) -> Bool {
        return lhs.value > rhs.value
    }
}

extension ByteCount: Numeric {
    public typealias Magnitude = Int
    public typealias IntegerLiteralType = Int

    static public var zero: ByteCount {
        return ByteCount(0)
    }

    public var magnitude: Int {
        return value
    }

    public init?<T>(exactly source: T) where T: BinaryInteger {
        self.value = Int(source)
    }

    public init(integerLiteral value: Int) {
        self.value = value
    }

    static public func - (lhs: ByteCount, rhs: ByteCount) -> ByteCount {
        return ByteCount(lhs.value - rhs.value)
    }

    static public func -= (lhs: inout ByteCount, rhs: ByteCount) {
        lhs.value -= rhs.value
    }

    static public func + (lhs: ByteCount, rhs: ByteCount) -> ByteCount {
        return ByteCount(lhs.value + rhs.value)
    }

    static public func += (lhs: inout ByteCount, rhs: ByteCount) {
        lhs.value += rhs.value
    }

    static public func * (lhs: ByteCount, rhs: ByteCount) -> ByteCount {
        return ByteCount(lhs.value * rhs.value)
    }

    static public func *= (lhs: inout ByteCount, rhs: ByteCount) {
        lhs.value *= rhs.value
    }
}

extension ByteCount: CustomStringConvertible {
    public var description: String {
        return "\(value)"
    }
}

extension ByteCount: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(value)"
    }
}
