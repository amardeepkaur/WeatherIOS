//
//  WeatherDetailsViewController.swift
//  ByteMark
//
//  Created by Amardeep Kaur on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableHeaderView: CityNameTableHeaderView?
    var cityList = [City]()
    var cityWeatherDetailsList = [Temperature]()
    var city : City?
    var temp : Temperature?
    var viewModel: WeatherDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableHeaderView = UINib(nibName: "CityNameTableHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CityNameTableHeaderView
        self.viewModel = WeatherDetailViewModel.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return self.cityList.count
        return self.viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableHeaderView?.frame.size.height ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.tableHeaderView?.cityNameLabel.text = viewModel?.titleForSection(iSectionIndex: section)
        self.tableHeaderView?.actualTempLabel.text = self.viewModel?.actualTempForHeader(iSectionIndex: section)
        self.tableHeaderView?.dateLabel.text = self.viewModel?.dateForHeader(iSectionIndex: section)
        return self.tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.cityWeatherDetailsList.count
        return self.viewModel?.numberOfRowsForSection(iSectionIndex: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let weatherForecastCell = tableView.dequeueReusableCell(withIdentifier: "weatherDetailCell", for: indexPath) as? WeatherDetailTableViewCell {
            let theWeatherTableViewCellModel = self.viewModel?.fetchWeatherInfoItemForIndexPath(iIndexPath: indexPath)
            weatherForecastCell.item = theWeatherTableViewCellModel
            
            return weatherForecastCell
        }
        return UITableViewCell.init()
    }

    @IBAction func dismissDetails(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
