//
//  SampleService.swift
//  TestProject
//
//  Created by Александр Сибирцев on 10.10.2020.
//

import Foundation
import Alamofire

class SampleService {
    
    func sampleData(completion: @escaping (SampleModel?, Error?) -> ()) {
        let currentURL = URL(string: "https://pryaniky.com/static/json/sample.json")!
        Alamofire.request(currentURL).responseJSON { (response) in
            
            switch response.result {
            case .success:
                guard let decodeData = SampleModel.decodeFromData(data: response.data!) else {
                    print("Decode error")
                    return
                }
                
                completion(decodeData, nil)
            case .failure:
                completion(nil, response.error)
            }
        }
    }

}

