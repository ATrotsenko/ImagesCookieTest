//
//  FlickerListViewModel.swift
//  LoremflickrCookie
//
//  Created by Alexey on 24.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class FlickerListViewModel: NSObject {
    
    private let networkService: NetworkServiceProtocol
    private var isLoading: Bool = false
    
    var itemsViewModels = [FlickerTableViewCellViewModel]()
    var reload: EmptyBlock?
    var showFlicker: ((FlickerModel) -> Void)?

    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init()
        self.addMore()
    }

    private func addMore() {
        if isLoading { return }
        isLoading = true
        
        let models = makeItems(self.itemsViewModels.count)
        let vms = models.map{ FlickerTableViewCellViewModel($0, networkService: self.networkService) }
        self.itemsViewModels += vms
        self.networkService.downloadData(models) { [weak self] in
            self?.reload?()
            self?.isLoading = false
        }
    }
    
    private func makeItems(_ startIdx: Int = 0) -> [FlickerModel] {
        var models = [FlickerModel]()
        for n in startIdx...startIdx+30 {
            let model = FlickerModel(idx: n)
            models.append(model)
        }
        return models
    }
}

extension FlickerListViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cls: FlickerItemTableViewCell.self, index: indexPath)
        cell.viewModel = itemsViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        itemsViewModels[indexPath.row].startImageDownload()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        itemsViewModels[indexPath.row].stopImageDownload()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = itemsViewModels[indexPath.row].model
        if (model.imageData != nil) {
            showFlicker?(itemsViewModels[indexPath.row].model)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height*2 {
            addMore()
        }
    }
}
