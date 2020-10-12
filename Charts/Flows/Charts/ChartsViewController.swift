//
//  ChartsViewController.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    //MARK: - Properties
    private let viewModel = ChartsViewModel()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchQuotes()
    }
    
    //MARK: - Public functions
    func configure(selectedDuration: ChartsDuration) {
        viewModel.duration = selectedDuration
    }
    
    //MARK: - Configure UI
    private func configureUI() {
        durationLabel.text = viewModel.duration.title
        configureLineChart()
    }
    
    private func configureLineChart() {
    }

    //MARK: - Configure Data
    private func fetchQuotes() {
        viewModel.fetchQuotes { [weak self] (quotes) in
            self?.configureLineChartData(with: quotes)
        } errorCompletion: { [weak self] (errorMessage) in
            self?.showAlert(with: errorMessage)
        }
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func configureLineChartData(with quotes: [QuoteSymbol]) {
        let colors: [UIColor] = [.red, .green, .yellow]
        let dataSets = quotes.enumerated().map { (index, quoteSymbol) -> LineChartDataSet in
            let perfomance = viewModel.calculatePerformance(for: quoteSymbol)
            let dataEntries = perfomance.map { ChartDataEntry(x: Double($1) ,y: $0) }
            
            let set = LineChartDataSet(entries: dataEntries, label: quoteSymbol.symbol)
            set.lineWidth = 1
            set.circleRadius = 3
            set.circleHoleRadius = 2
            let color = colors[index]
            set.setColor(color)
            set.setCircleColor(.black)
            
            return set
            
        }
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 9))
        
        lineChartView.data = data
    }
    
    //MARK: - Actions
    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
