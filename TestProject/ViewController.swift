//
//  ViewController.swift
//  TestProject
//
//  Created by Александр Сибирцев on 10.10.2020.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView! {
        didSet {
            logoImage.isHidden = true
        }
    }
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.isHidden = true
        }
    }

    
    var arrayData: [SampleData]?
    var arrayView: [String]?
    
    var service: SampleService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
       
        service = SampleService()
        
        service?.sampleData(completion: { (sample, error) in
            print(sample!)
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            self.arrayData = sample?.data
            self.arrayView = sample?.view
            
            self.logoImage.kf.indicatorType = .activity
            self.logoImage.kf.setImage(with: URL(string: self.arrayData![1].data.url!))
            
            self.titleLabel.text = self.arrayData![0].data.text
            
            self.segmentController.removeAllSegments()
            
            for (i,j) in self.arrayView!.enumerated() {
                self.segmentController.insertSegment(withTitle: j, at: i, animated: true)
            }
            self.segmentController.selectedSegmentIndex = 0
            
            self.pickerView.reloadAllComponents()
           
        })
        
    }

    @IBAction func segmentControllerAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let name = sender.titleForSegment(at: sender.selectedSegmentIndex)!
            
            self.titleLabel.text = self.arrayData![Index(name: name)].data.text
            
            pickerView.isHidden = true
            logoImage.isHidden = true
        case 1:
            let name = sender.titleForSegment(at: sender.selectedSegmentIndex)!
            
            self.titleLabel.text = self.arrayData![Index(name: name)].data.text
            
            pickerView.isHidden = false
            logoImage.isHidden = true
        case 2:
            let name = sender.titleForSegment(at: sender.selectedSegmentIndex)!
            
            self.titleLabel.text = self.arrayData![Index(name: name)].data.text
            
            pickerView.isHidden = true
            logoImage.isHidden = false
        case 3:
            let name = sender.titleForSegment(at: sender.selectedSegmentIndex)!
            
            self.titleLabel.text = self.arrayData![Index(name: name)].data.text
            
            pickerView.isHidden = true
            logoImage.isHidden = true
        default:
            fatalError()
        }
    }
    
    func returnName(name: String) -> String {
        for i in arrayData! {
            if i.name == name {
                return name
            }
        }
        return ""
    }
    
    func Index(name: String) -> Int {
        if let index = self.arrayData!.firstIndex(where: { $0.name == returnName(name: name)}) {
            return index
        }
        return 0
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayData?[2].data.variants?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let a = arrayData?[2]

        if a?.name == "selector" {
            var arr = [String]()
            arr.removeAll()
            for i in a!.data.variants! {
                arr.append(i.text)

            }
            return arr[row]

        }
        return ""
    }
    
}

