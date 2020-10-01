//
//  PointsViewController.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

// MARK: - PointsViewController
class PointsViewController: BaseViewController<PointsViewModel> {
    private struct Constants {
        static let optimalRowHeight: CGFloat = 54
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func setupUI() {
        super.setupUI()
        title = viewModel.title
        tableView.rowHeight = Constants.optimalRowHeight
        tableView.estimatedRowHeight = Constants.optimalRowHeight
        tableView.register(PointCell.nib, forCellReuseIdentifier: PointCell.nibName)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()
        viewModel.reload = {
            [weak self] in
            
            self?.tableView.reloadData()
        }
        
        viewModel.addPoints = {
            [weak self] indexPaths in
            
            self?.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

// MARK: - UITableViewDataSource
extension PointsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointCell.nibName, for: indexPath) as! PointCell
        cell.configure(with: viewModel.points[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PointsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row > viewModel.points.count - 3 else { return }
        viewModel.getMorePoints()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.optimalRowHeight
    }
}
