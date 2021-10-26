//
//  DashboardLandingView.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

class DashboardLandingView: BaseViewController, DashboardLandingPresenterToView {
    var presenter: DashboardLandingViewToPresenter?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    init() {
        super.init(nibName: String(describing: DashboardLandingView.self), bundle: Bundle(for: DashboardLandingView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        presenter?.viewDidload()
        searchBar.delegate = self
    }
    
    private func setUpViews() {
        self.title = "Popular Movies"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Identifiers.sectionTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.sectionTableViewCell)
        tableView.register(UINib(nibName: Constants.Identifiers.movieTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.movieTableViewCell)
        showLoader(true)
        tableView.backgroundColor = hexStringToUIColor(hex: "#f7f7f7")
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), style: .done, target: self, action: #selector(showFavourites))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func showFavourites() {
        presenter?.showFavouriteMovieList()
    }
 
    func reloadView() {
        showLoader(false)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoader(_ isShowing: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = !isShowing
            isShowing ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func showAlert(titleStr: String?, messageStr: String?, actionTitles:[String?]) {
        showAlertMessage(vc: self, titleStr: titleStr, messageStr: messageStr, actionTitles: actionTitles, actions:[{ okAction in
            self.dismiss(animated: true, completion: nil)
        }])
    }
}

extension DashboardLandingView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableSection = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.sectionTableViewCell) as? SectionTableViewCell, let viewModel = presenter?.viewForHeader(in: section) else { return UITableViewCell() }
        tableSection.bind(viewModel: viewModel)
        return tableSection.contentView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.movieTableViewCell) as? MovieTableViewCell, let viewModel = presenter?.model(for: indexPath) else { return UITableViewCell() }
        tableCell.bind(from: viewModel)

        tableCell.favouriteCallback = { [weak self] in
            self?.presenter?.markFavourite(for: indexPath)
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedModel(for: indexPath)
    }
}

extension DashboardLandingView: UISearchBarDelegate {
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.getSearch(text: searchBar.text ?? "")
    }
    
}
