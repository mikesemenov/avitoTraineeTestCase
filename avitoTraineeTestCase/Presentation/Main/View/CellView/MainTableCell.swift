//
//  MainTableCell.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import UIKit

class MainTableCell: UITableViewCell {
 
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!

    // MARK: Functions and Methods 😅
    
    func configureView() {
        self.backgroundColor = .systemBackground
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

}
