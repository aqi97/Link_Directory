//
//  LinkOverlayView.swift
//  LinkDirwctor
//
//  Created by Sheikh Abu mohamed on 22/12/24.
//

import SwiftUI

struct LinkOverlayView: View {
    let text: String
    let onTapLink: (URL) -> Void
    let onTapText: (CGPoint) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .contentShape(Rectangle())
                .gesture(
                    TapGesture()
                        .onEnded { value in
                            let tapLocation = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            handleTap(at: tapLocation, in: geometry.size)
                        }
                )
        }
    }
    
    private func handleTap(at point: CGPoint, in size: CGSize) {
        if let url = findLinkAt(point, in: size) {
            onTapLink(url)
        } else {
            onTapText(point)
        }
    }
    
    private func findLinkAt(_ point: CGPoint, in size: CGSize) -> URL? {
        let links = LinkDetector.findLinks(in: text)
        let textHeight = size.height / CGFloat(links.count + 1)
        
        for (index, (_, url)) in links.enumerated() {
            let linkFrame = CGRect(x: 0, y: textHeight * CGFloat(index), width: size.width, height: textHeight)
            if linkFrame.contains(point) {
                return url
            }
        }
        return nil
    }
}
