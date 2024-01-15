//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 03/01/24.
//

import UIKit
import MoviesUIKit

class MoviesListViewController: CommonAppViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = MoviesConstants.AccessibilityIdentifiers.moviesTableView
        }
    }
    
    private var viewModel = FetchMoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.title = MovieStrings.moviesText

        // Do any additional setup after loading the view.
        configureTableView()
        addLogoutMenuButton()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: MovieTableCell.classNameValue(), bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: MovieTableCell.classNameValue())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.reloadData()
        viewModel.fetchMovies { error in
            if error == nil {
                self.tableView.reloadData()
            }
        }
    }
    
    private func addLogoutMenuButton() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logoutButtonClicked))
        rightBarButton.accessibilityIdentifier = "rightBarButton"
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func logoutButtonClicked() {
        if  let loginVC = self.storyboard?.instantiateViewController(withIdentifier: LoginViewController.classNameValue()) {
            self.navigationController?.viewControllers = [loginVC]
        }
    }
    
}


extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.classNameValue()) as? MovieTableCell else {
            return UITableViewCell()
        }
        tableCell.accessibilityIdentifier = MovieTableCell.classNameValue() + "\(indexPath.row)"
        tableCell.configCell(movieData: self.viewModel.getMovieData(for: indexPath), indexPath: indexPath)
        return tableCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}



