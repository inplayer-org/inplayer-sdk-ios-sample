import UIKit

extension String {
    func substring(_ from: Int) -> String {
        let index = self.index(startIndex, offsetBy: from)
        let substring = self[index...]
        return String(substring)
    }
    
    var length: Int {
        return self.count
    }
    
    func isEmptyString() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }

    var floatValue: Float? {
        return NumberFormatter().number(from: self)?.floatValue
    }

    var intValue: Int? {
        return Int(self)
    }

}

extension Substring {
    var floatValue: Float? {
        return NumberFormatter().number(from: String(self))?.floatValue
    }

    var intValue: Int? {
        return Int(String(self))
    }
}
