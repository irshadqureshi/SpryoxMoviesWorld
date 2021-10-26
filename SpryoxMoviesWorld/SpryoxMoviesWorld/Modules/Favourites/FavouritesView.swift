//
//  FavouritesView.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

class FavouritesView: BaseViewController, FavouritesPresenterToView {
    var presenter: FavouritesViewToPresenter?
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: String(describing: FavouritesView.self), bundle: Bundle(for: FavouritesView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        presenter?.viewDidload()
    }
    
    private func setUpViews() {
        self.title = "Popular Movies"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Identifiers.sectionTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.sectionTableViewCell)
        tableView.register(UINib(nibName: Constants.Identifiers.movieTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.movieTableViewCell)
        tableView.backgroundColor = hexStringToUIColor(hex: "#f7f7f7")
    }
  
    func reloadView() {
        DispatchQueue.main.async { 
            self.tableView.reloadData()
        }
    }
}

extension FavouritesView: UITableViewDelegate, UITableViewDataSource {
    
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
}

