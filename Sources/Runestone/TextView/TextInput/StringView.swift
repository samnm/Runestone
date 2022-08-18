import Foundation

public final class StringViewBytesResult {
    // The bytes are not deallocated by this type.
    public let bytes: UnsafePointer<Int8>
    public let length: ByteCount

    public init(bytes: UnsafePointer<Int8>, length: ByteCount) {
        self.bytes = bytes
        self.length = length
    }
}

public final class StringView {
    public var string: NSString {
        get {
            return internalString
        }
        set {
            internalString = NSMutableString(string: newValue)
        }
    }
    private var internalString: NSMutableString {
        didSet {
            if internalString != oldValue {
                invalidate()
            }
        }
    }
    public var swiftString: String {
        if let swiftString = _swiftString {
            return swiftString
        } else {
            let swiftString = internalString as String
            _swiftString = swiftString
            return swiftString
        }
    }

    private var _swiftString: String?

    public init(string: NSMutableString = NSMutableString()) {
        self.internalString = string
    }

    public convenience init(string: String) {
        self.init(string: NSMutableString(string: string))
    }

    public func substring(in range: NSRange) -> String? {
        if range.location >= 0 && range.upperBound <= internalString.length && range.length > 0 {
            return internalString.substring(with: range)
        } else {
            return nil
        }
    }

    public func character(at location: Int) -> Character? {
        if location >= 0 && location < string.length, let scalar = Unicode.Scalar(internalString.character(at: location)) {
            return Character(scalar)
        } else {
            return nil
        }
    }

    public func replaceText(in range: NSRange, with string: String) {
        internalString.replaceCharacters(in: range, with: string)
        invalidate()
    }

    public func bytes(in range: ByteRange) -> StringViewBytesResult? {
        guard range.lowerBound.value >= 0 && range.upperBound <= string.byteCount else {
            return nil
        }
        let stringRange = NSRange(range)
        var usedLength = 0
        if let buffer = string.getBytes(in: stringRange, encoding: String.preferredUTF16Encoding, usedLength: &usedLength) {
            return StringViewBytesResult(bytes: buffer, length: ByteCount(usedLength))
        } else {
            return nil
        }
    }
}

private extension StringView {
    private func invalidate() {
        _swiftString = nil
    }
}
