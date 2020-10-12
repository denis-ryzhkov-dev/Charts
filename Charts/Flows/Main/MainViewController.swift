//
//  MainViewController.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Navigation
    private func openCharts(for type: ChartsDuration) {
        let viewController = ChartsViewController.initWithNib() as! ChartsViewController
        viewController.configure(selectedDuration: type)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func weekButtonTouched(_ sender: Any) {
        openCharts(for: .week)
    }
    
    @IBAction func monthButtonTouched(_ sender: Any) {
        openCharts(for: .month)
    }
}
