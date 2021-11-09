//
//  OnboardsEnum.swift
//  formApp
//
//  Created by MacBook Pro on 08.04.2021.
//

import UIKit

// MARK: - OnboardsEnum
enum OnboardsEnum: CaseIterable {
    case firstSlide
    case secondSlide
    case thirdSlide
    
    // MARK: - Title
    var title: String {
        switch self {
        case .firstSlide: return "Send your forms easy and fast"
        case .secondSlide: return "Acess your forms with a single tap"
        case .thirdSlide: return "All power of forms in palm of your hand"
        }
    }
    
    // MARK: - image
    var image: UIImage {
        switch self {
        case .firstSlide: return UIImage(named: "slide1")!
        case .secondSlide: return UIImage(named: "slide2")!
        case .thirdSlide: return UIImage(named: "slide3")!
        }
    }
}
