//
//  DemoViewController.swift
//  ProfilePicture
//
//  Created by Dan Leonard on 3/18/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    
    @IBOutlet weak var avatar: AvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.setup(initials: "DL", imageURL: nil)
        avatar.setImageForAvatarView(UIImage(named: "dan")!)
        // Do any additional setup after loading the view.
    }

}
