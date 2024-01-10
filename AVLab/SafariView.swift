//
//  WKWebview.swift
//  AVLab
//
//  Created by ney on 2024/1/10.
//

import Foundation
import WebKit
import UIKit
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL = URL(string: "https://v.qq.com")!
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.activityButton = nil
        config.barCollapsingEnabled = false
        config.entersReaderIfAvailable = false
        let safariVC = SFSafariViewController(url: url, configuration: config)
        safariVC.preferredBarTintColor = .clear
        safariVC.preferredControlTintColor = .clear
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
