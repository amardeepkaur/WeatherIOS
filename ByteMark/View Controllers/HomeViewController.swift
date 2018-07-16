//
//  ViewController.swift
//  ByteMark
//
//  Created by Amardeep on 12/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: HomeViewModel = HomeViewModel()

    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupViewModelClosures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Other methods
    
    func setupUI() {
        self.title = self.viewModel.screenTitle
        self.cityTextfield.placeholder = self.viewModel.cityTextfieldPlaceHolder
        self.searchButton.setTitle(self.viewModel.buttonTitle, for: .normal)
    }
    
    func setupViewModelClosures() {
        self.viewModel.showAlertClosure = {[weak self] (_ iTitleString, iMessageString, iCancelButtonString) in
            //TODO: Handle the error alert
            let alertController = UIAlertController.init(title: iTitleString, message: iMessageString, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self?.present(alertController, animated: true, completion: nil)
        }
        
        self.viewModel.handleDetailNavigationClosure = {
            //TODO: Handle the navigation to the detail screen
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let weatherDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController {
                self.present(weatherDetailViewController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.viewModel.handleSearchButtonAction(iCityNames: self.cityTextfield.text!)
    }
    
    @IBAction func currentLocationButtonAction(_ sender: Any) {
        self.viewModel.handleCurrentLocationButtonAction()
    }
}

