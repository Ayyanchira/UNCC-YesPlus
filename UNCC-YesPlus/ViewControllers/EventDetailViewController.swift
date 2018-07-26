//
//  EventDetailViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/19/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var eventCellView: EventCellView!
    //var scrollView:UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add a scrollview
//        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: eventCellView.frame.height + 200))
//        scrollView?.addSubview(eventCellView)
        scrollview.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height)
        scrollview.alwaysBounceHorizontal = false
        scrollview.showsVerticalScrollIndicator = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: eventCellView.frame.height * 2)
       scrollview.addSubview(eventCellView)
    }

}
