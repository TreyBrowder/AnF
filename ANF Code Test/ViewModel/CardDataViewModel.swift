//
//  CardDataViewModel.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import Foundation

class CardDataViewModel {
    @Published var exploreDataArr = [ExploreCard]()
    @Published var errorMsg: String?
    
    private let service: CardDataProtocol
    
    init(service: CardDataProtocol) {
        self.service = service
    }
    
    func getCardData() async {
        do {
            let data = try await service.fetchCardData()
            print("Result: - \(data)")
            await MainActor.run {
                self.exploreDataArr = data
            }
        } catch {
            guard let err = error as? APIError else { return }
            print("DEBUG - ERROR: - \(err.errMsg)")
            await MainActor.run {
                self.errorMsg = err.errMsg
            }
        }
    }
}
