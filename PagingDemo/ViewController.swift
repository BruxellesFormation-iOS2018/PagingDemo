//
//  ViewController.swift
//  test
//
//  Created by Florian Praile on 11/09/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var pageViewController: UIPageViewController!
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let blueVc = storyboard.instantiateViewController(withIdentifier: "blue")
        let redVC = storyboard.instantiateViewController(withIdentifier: "red")
        let grayVC = storyboard.instantiateViewController(withIdentifier: "gray")
        return [blueVc, redVC, grayVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([orderedViewControllers.first!],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embededPaging"{
            pageViewController = segue.destination as! UIPageViewController
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let next = orderedViewControllers.index(of: viewController)! + 1
        if next < orderedViewControllers.count{
            return orderedViewControllers[next]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let prev = orderedViewControllers.index(of: viewController)! - 1
        if prev >= 0{
            return orderedViewControllers[prev]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed { return}
        if let vc = pageViewController.viewControllers?.first{
            self.segmentedControl.selectedSegmentIndex = orderedViewControllers.index(of: vc)!
        }
        
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        let newIndex = self.segmentedControl.selectedSegmentIndex
        if let vc = pageViewController.viewControllers?.first{
            let currentIndex = orderedViewControllers.index(of: vc)!
            pageViewController.setViewControllers([orderedViewControllers[newIndex] ],
                                                  direction: currentIndex < newIndex ? .forward : .reverse ,
                                                  animated: true,
                                                  completion: nil)
        }
        
    }
    
    
}

