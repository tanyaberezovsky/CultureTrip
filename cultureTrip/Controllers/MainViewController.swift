//
//  ViewController.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var urlComponents = URLComponents(string: "https://cdn.theculturetrip.com")!
        urlComponents.path = "/home-assignment/response.json"
        print(urlComponents.url)

    }


}

