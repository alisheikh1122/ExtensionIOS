//
//  ViewController.swift
//  practice
//
//  Created by Ali Shahzad on 16/04/2025.
//

import UIKit
import ExtensionIOS

class ViewController: UIViewController {

    @IBOutlet weak var shimmerView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shimmerView.addShimmer()
    }


}

