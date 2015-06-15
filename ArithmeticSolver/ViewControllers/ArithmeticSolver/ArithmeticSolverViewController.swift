//
//  ViewController.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/12/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import UIKit
import ReactiveCocoa
import TableAdapter

class ArithmeticSolverViewController: UIViewController {
    let viewModel = ArithmeticSolverViewModel()
    
    @IBOutlet
    private var expressionTextField: UITextField!
    
    @IBOutlet
    private var solveButton: UIButton!
    
    @IBOutlet
    private var stepsTableView: UITableView!
    
    private let tableViewDataSource = TableViewDataSource()
    private let stepsTableViewSection = TableViewSection()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Private API

// MARK: Setup

private extension ArithmeticSolverViewController {
    func setup() {
        setupTableView()
        setupSignals()
    }
    
    func setupSignals() {
        // Bind `expressionTextField` text signal to `viewModel.expression`
        RAC(viewModel, "expression") <~ expressionTextField.rac_textSignal()
        
        /**
            When `solveButton` receives a touch up inside event,
            solve the expression, and update the table view.
         */
        solveButton
            .rac_signalForControlEvents(.TouchUpInside)
            .flattenMap { _ in
                return self.viewModel.solveExpressionSignal()
            }
            .subscribeNextAs { (solution: Solution) in
                self.stepsTableViewSection.objects = solution.steps
                self.tableViewDataSource.reloadSections()
            }
    }
    
    func setupTableView() {
        let stepCellIdentifier = "StepCell"
        let stepCellNib = UINib(nibName: "StepCell", bundle: nil)
        
        stepsTableView.estimatedRowHeight = 50
        stepsTableView.registerNib(stepCellNib, forCellReuseIdentifier: stepCellIdentifier)
        tableViewDataSource.tableView = stepsTableView
        
        stepsTableViewSection.cellIdentifier = { _, _ in return stepCellIdentifier }
        stepsTableViewSection.cellConfiguration = { cell, item, indexPath in
            if let cell = cell as? StepCell, operation = item as? Operation {
                let viewModel = StepCellViewModel(operation: operation)
                cell.bindWithViewModel(viewModel)
            }
        }
        
        tableViewDataSource.addSection(stepsTableViewSection)
    }
}
