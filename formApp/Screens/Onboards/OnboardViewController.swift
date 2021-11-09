//
//  ContentViewController.swift
//  formApp
//
//  Created by MacBook Pro on 05.04.2021.
//

import UIKit

class OnboardViewController: UIViewController {
    
    // MARK: - Properties
    var slides: [SlidesView] = []
    var currentPageIndex: Int = 1
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var skipButtonOutlet: UIButton!

    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        backButtonOutlet.isHidden = true
    }
    
    // MARK: - IBActions
    @IBAction func nextTapButton(_ sender: UIButton) {
        let nextPageRect = CGRect(x: view.frame.width * CGFloat(self.currentPageIndex),
                                  y: 0,
                                  width: view.frame.width, height: view.frame.height)
        scrollView.scrollRectToVisible(nextPageRect, animated: true)
        
        if currentPageIndex == 3 {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK:  goBacktTapButton
    @IBAction func goBacktTapButton(_ sender: UIButton) {
        let nextPageRect = CGRect(x: view.frame.width * CGFloat(self.currentPageIndex - 2),
                                  y: 0,
                                  width: view.frame.width, height: view.frame.height)
        scrollView.scrollRectToVisible(nextPageRect, animated: true)
    }
    
    // MARK:  skipTapButton
    @IBAction func skipTapButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIScrollView Delegate
extension OnboardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / self.view.frame.width)
        let page: Int = Int(pageIndex)
        self.currentPageIndex = page + 1
        
        if slides.count == (page + 3) {
            backButtonOutlet.isHidden = true
        } else {
            backButtonOutlet.isHidden = false
        }
    }
}

// MARK: - Setup
private extension OnboardViewController {
    func setup() {
        slidesFilling()
        scrollViewConfigure()
        setupSlidersToScroll(slides)
        backButtonOutlet.isHidden = true
    }
    
    // MARK:  scrollViewConfigure
    func scrollViewConfigure() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
    }
    
    // MARK:  slidesFilling
    func slidesFilling() {
        OnboardsEnum.allCases.forEach { value in
            let slide = SlidesView.viewFromNibName("Slides") as! SlidesView
            slide.viewConfigure(with: value)
            self.slides.append(slide)
        }
    }
    
    // MARK:  setupSlidersToScroll
    func setupSlidersToScroll(_ slides: [SlidesView]) {
        scrollView.isPagingEnabled = true
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        let scrollViewContentWidth: CGFloat = view.frame.width * CGFloat(slides.count)
        
        scrollView.contentSize = CGSize(width: scrollViewContentWidth,
                                        height: 350)
        
        for item in 0 ..< slides.count {
            slides[item].frame = CGRect(x: view.frame.width * CGFloat(item), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[item])
        }
        
    }
}

