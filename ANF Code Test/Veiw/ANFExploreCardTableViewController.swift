//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

extension ANFExploreCardTableViewController: CardDataViewModelDelegate {
    func didUpdateData(_ viewModel: CardDataViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didReceiveError(_ viewModel: CardDataViewModel, error: String) {
        DispatchQueue.main.async {
            print("Error: \(error)")
            //TODO: - Handle Error
        }
    }
}

class ANFExploreCardTableViewController: UITableViewController {
    private var exploreData: [[AnyHashable: Any]]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
            return jsonDictionary
        }
        return nil
    }
    
    private let cardVM = CardDataViewModel(service: CardDataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setDelegate()
        
        Task { await cardVM.getCardData() }
    }
    
    private func setUpTable() {
        tableView.register(ExploreCardTableViewCell.self, forCellReuseIdentifier: "exploreCardCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setDelegate() {
        cardVM.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardVM.exploreDataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = cardVM.exploreDataArr[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCardCell", for: indexPath) as? ExploreCardTableViewCell else { return UITableViewCell() }
        
        
        let cellVM = CellViewModel(card: card)
        cell.configure(with: cellVM)
        
        return cell
    }
}
