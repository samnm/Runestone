import Foundation

public enum NewLineFinder {
    public static func rangeOfNextNewLine(in text: NSString, startingAt location: Int) -> NSRange? {
        let range = NSRange(location: location, length: 0)
        var end: Int = NSNotFound
        var contentsEnd: Int = NSNotFound
        text.getLineStart(nil, end: &end, contentsEnd: &contentsEnd, for: range)
        if end != NSNotFound && contentsEnd != NSNotFound && end != contentsEnd {
            return NSRange(location: contentsEnd, length: end - contentsEnd)
        } else {
            return nil
        }
    }
}
