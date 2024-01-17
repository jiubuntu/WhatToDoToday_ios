//
//  AddPreview.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/17/24.
//

import UIKit
import SwiftUI

// MARK: - preview를 위한...
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let vc: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return vc
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(vc: self)
    }
}
