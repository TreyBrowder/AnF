//
//  CardDataViewModel.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import Foundation

@MainActor
protocol CardDataViewModelDelegate: AnyObject {
    func didUpdateData(_ viewModel: CardDataViewModel)
    func didReceiveError(_ viewModel: CardDataViewModel, error: String)
}

class CardDataViewModel {
    
    private(set) var exploreDataArr = [ExploreCard]()
    private(set) var errorMsg: String?
    
    private let service: CardDataProtocol
    weak var delegate: CardDataViewModelDelegate?
    let queue = DispatchQueue(label: "com.AnFCodeTest.CardDataVM", attributes: .concurrent)
    
    init(service: CardDataProtocol) {
        self.service = service
    }
    
    @MainActor
    func getCardData() async {
        do {
            let data = try await service.fetchCardData()
            self.exploreDataArr = data
            self.delegate?.didUpdateData(self)
        } catch {
            guard let err = error as? APIError else { return }
            print("DEBUG - ERROR: - \(err.errMsg)")
            await MainActor.run {
                self.errorMsg = err.errMsg
                self.delegate?.didReceiveError(self, error: err.errMsg)
            }
        }
    }
}
