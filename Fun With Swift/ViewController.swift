//
//  ViewController.swift
//  Fun With Swift
//
//  Created by Pedro Paulo Amorim on 22/09/15.
//  Copyright © 2015 Pedro Paulo Amorim. All rights reserved.
//

import UIKit
import Cartography

class ViewController : UIViewController {
    
    private var buttonOne : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        addButtonOne()
        
        // Do any additional setup after loading the view, typically from a nib.
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.startSecondViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtonOne() -> Void {
        buttonOne = UIButton()
        buttonOne.backgroundColor = UIColor.greenColor()
        self.view.addSubview(buttonOne)
        
        constrain(buttonOne, self.view) { buttonOne, view in
            buttonOne.left == view.right - 12
            buttonOne.right == view.left + 12
            buttonOne.bottom == view.bottom - 12
        }
        
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        
    }

}

