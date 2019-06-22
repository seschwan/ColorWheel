//
//  ViewController.swift
//  ColorWheel
//
//  Created by Corey Sessions on 6/20/19.
//  Copyright © 2019 Corey Sessions. All rights reserved.
//

import UIKit

class ViewController: UIViewController { //LosslessStringConvertible {
    
//    required init?(_ description: String) {
//        var redValue = colorWheel.color.rgba.red
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    let colorWheel = ColorWheel()
    
    @IBOutlet weak var redLblValue: UILabel!
    
    @IBOutlet weak var greenLblValue: UILabel!
    
    @IBOutlet weak var blueLblValue: UILabel!
    
    @IBAction func colorChanged(_ sender: ColorWheel) {
        view.backgroundColor = sender.color
    }
    @IBAction func touchUpInside(_ sender: Any) {
        //view.backgroundColor = .white
    }
    @IBAction func touchDragOutside(_ sender: Any) {
        view.backgroundColor = .white
    }
    
    func updateLabels() {
        var redValue = colorWheel.color.rgba.red
        //redLblValue.text = String(redValue)
    }
    
}

