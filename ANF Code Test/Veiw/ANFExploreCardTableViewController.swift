//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    private let service: CardDataProtocol
    lazy var cardVM = CardDataViewModel(service: service)
    
    init(service: CardDataProtocol = CardDataService()) {
        self.service = service
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        
        let cellVM = CellViewModel(card: card, imageService: service)
        cell.configure(with: cellVM)
        
        return cell
    }
}

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
