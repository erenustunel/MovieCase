//
//  HomeVC.swift
//  MovieCase
//
//  Created by Eren Üstünel on 13.03.2022.
//

import UIKit

final class HomeVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private var vm = HomeVM()

    private var searchText: String? {
        didSet {
            vm.getSearchMovie(searchText: searchText)
        }
    }
    
    private var movieResponse : MovieSearchResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        vm.delegate = self
        searchBar.delegate = self
    }
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.registerCells([HomeCell.self])
    }
}

extension HomeVC: HomeVMDelegate {
    func didGetMoviesResponse(movie: MovieSearchResponse) {
        if movie.Search?.count == 0 {
            tableView.showEmptyLabel(message: "Movie is not found", containerView: self.tableView)
        }else {
            movieResponse = movie
            tableView.hideTableViewEmptyMessage()
            tableView.reloadData()
            
        }
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResponse?.Search?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        if let searchMovies = movieResponse {
            cell.setCell(movie: searchMovies.Search?[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC(nibName: "DetailVC", bundle: nil)
        vc.vm = DetailVM(imdbId: movieResponse?.Search?[indexPath.row].imdbID ?? "")
        self.animateNavigate(vc: vc)
    }
    
    
}
