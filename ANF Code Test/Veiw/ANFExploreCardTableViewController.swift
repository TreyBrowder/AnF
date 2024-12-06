//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    private let service: CardDataProtocol
    lazy var cardVM = CardDataViewModel(service: service)
    
    // MARK: - Initializer
    init(service: CardDataProtocol = CardDataService()) {
        self.service = service
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setDelegate()
        
        // Fetch data
        Task {
            await fetchData()
        }
    }
    
    // MARK: - Private Methods
    private func setUpTable() {
        tableView.register(ExploreCardTableViewCell.self, forCellReuseIdentifier: "exploreCardCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setDelegate() {
        cardVM.delegate = self
    }
    
    private func fetchData() async {
        await cardVM.getCardData()
    }
    
    private func handleError(_ message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
            Task(priority: .background) {
                await self.fetchData()
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardVM.exploreDataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = cardVM.exploreDataArr[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCardCell", for: indexPath) as? ExploreCardTableViewCell else {
            return UITableViewCell()
        }
        
        let cellVM = CellViewModel(card: card, imageService: service)
        cell.configure(with: cellVM)
        
        return cell
    }
}

// MARK: - CardDataViewModelDelegate
extension ANFExploreCardTableViewController: CardDataViewModelDelegate {
    func didUpdateData(_ viewModel: CardDataViewModel) {
        Task { @MainActor in
            self.tableView.reloadData()
        }
    }
    
    func didReceiveError(_ viewModel: CardDataViewModel, error: String) {
        Task { @MainActor in
            self.handleError(error)
        }
    }
}
