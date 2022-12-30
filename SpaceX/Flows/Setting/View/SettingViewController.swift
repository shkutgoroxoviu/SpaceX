//
//  TestViewController.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 07.09.2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    var completion: () -> Void = { }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var choiceHeightSegment: UISegmentedControl!
    @IBOutlet weak var choiceDiametrSegment: UISegmentedControl!
    @IBOutlet weak var choiceWeightSegment: UISegmentedControl!
    @IBOutlet weak var choicePayloadSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configSegments()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        completion()
    }
    
    func configSegments() {
        choiceHeightSegment.selectedSegmentIndex = UserDefaults.height
        choiceDiametrSegment.selectedSegmentIndex = UserDefaults.diametr
        choiceWeightSegment.selectedSegmentIndex = UserDefaults.mass
        choicePayloadSegment.selectedSegmentIndex = UserDefaults.payload
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeHeight(_ sender: Any) {
        UserDefaults.height = choiceHeightSegment.selectedSegmentIndex
    }
    
    @IBAction func changeDiametr(_ sender: Any) {
        UserDefaults.diametr = choiceHeightSegment.selectedSegmentIndex
    }
    
    @IBAction func changeWeight(_ sender: Any) {
        UserDefaults.mass = choiceHeightSegment.selectedSegmentIndex
    }
    
    @IBAction func changePayload(_ sender: Any) {
        UserDefaults.payload = choiceHeightSegment.selectedSegmentIndex
    }
    
    func configUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
    }
}


