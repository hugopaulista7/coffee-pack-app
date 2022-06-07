//
//  HomeCardViewController.swift
//  Coffee Pack
//
//  Created by Hugo Paulista on 07/06/22.
//

import UIKit

class HomeCardViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var descriptionLabelOutlet: UILabel!
    
    // MARK: - Declarations
    
    func setContent(title: String, description: String, image: String) {
        titleLabelOutlet?.text = title
        descriptionLabelOutlet?.text = description
    }

}
