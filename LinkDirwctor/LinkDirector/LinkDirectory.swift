//
//  LinkDetector.swift
//  LinkDirwctor
//
//  Created by Sheikh Abu mohamed on 22/12/24.
//

import Foundation

struct LinkDetector {
    static func findLinks(in text: String) -> [(Range<String.Index>, URL)] {
        var links: [(Range<String.Index>, URL)] = []
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let matches = detector?.matches(
            in: text,
            options: [],
            range: NSRange(location: 0, length: text.utf16.count)
        )
        
        matches?.forEach { match in
            if let range = Range(match.range, in: text),
               let url = match.url {
                links.append((range, url))
            }
        }
        
        return links
    }
}
