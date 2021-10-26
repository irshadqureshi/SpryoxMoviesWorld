//
//  SectionTableViewCell.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

class SectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(viewModel: HomeSectionCellViewModelProtocol) {
        titleLabel.text = viewModel.titleString
    }
}

protocol HomeSectionCellViewModelProtocol {
    var titleString: String {get set}
}
