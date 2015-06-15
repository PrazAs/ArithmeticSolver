//
//  StepTableViewCell.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/15/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import UIKit

class StepCellViewModel: NSObject {
    let step: String
    let answer: String
    
    init(operation: Operation) {
        self.step = operation.description
        self.answer = "\(operation.solve())"
    }
}

class StepCell: UITableViewCell {
    @IBOutlet
    private var stepLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindWithViewModel(viewModel: StepCellViewModel) {
        stepLabel.text = "\(viewModel.step) = \(viewModel.answer)"
    }

}
