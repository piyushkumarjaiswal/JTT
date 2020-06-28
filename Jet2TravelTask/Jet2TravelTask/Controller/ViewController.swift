//
//  ViewController.swift
//  Jet2TravelTask
//
//  Created by Piyush on 27/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  /// View Model
  private var viewModel: ViewModel?
  /// Flag for animation
  private var shouldAnimatedLoading = true
  /// Table View
  @IBOutlet private weak var tableView: UITableView!
  /// Load More Button
  @IBOutlet private weak var buttonLoadMore: SpinnerButton!
  /// Container For Bottom Progress
  @IBOutlet private weak var conainerActivity: UIView!
  /// loading indicator button instance
  @IBOutlet private weak var progressIndicator: SpinnerButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModel()
    // Do any additional setup after loading the view.
  }
  
  /// Preparing View Model
  private func prepareViewModel() {
    viewModel = ViewModel()
    viewModel?.viewModelBinding = { [weak self] result, _ in
      guard let weakSelf = self else {
        return
      }
      weakSelf.tableView.reloadData()
      weakSelf.shouldAnimate(status: false)
      weakSelf.buttonLoadMore.isHidden = true
      weakSelf.conainerActivity.isHidden = true
      weakSelf.showLoader(status: false)
      weakSelf.buttonLoadMore.animate(animation: .expand)
    }
    if viewModel?.currentPage == 0 {
      buttonLoadMore.animate(animation: .collapse)
      showLoader(status: true)
      viewModel?.getPostFromApi(index: 1)
    }else {
      shouldAnimate(status: false)
      showLoader(status: false)
      tableView.reloadData()
    }
    conainerActivity.isHidden = true
    
    
  }
  
  /// Internal helper for animation
  private func shouldAnimate(status: Bool, delay: Double = 1.0) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
      self.shouldAnimatedLoading = status
    }
  }
  /// Internal Helper for loading
  private func showLoader(status: Bool) {
    progressIndicator.isHidden = !status
    progressIndicator.animate(animation: (status == true) ? .collapse : .expand)
  }
  //MARK: - User Actions
  /// Action On LoadMore Bottom Of Table
  @IBAction func actionOnLoadMore(_ sender: Any) {
    viewModel?.getPostFromApi()
    showLoader(status: false)
    buttonLoadMore.animate(animation: .collapse)
  }
}

//MARK: - TableView DataSource
extension ViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.feeds?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier:
      CellIdentifiers.tableViewCell,
                                                   for: indexPath) as? TableViewCell
      else { return UITableViewCell() }
    if let item = viewModel?.feeds?[indexPath.row] {
      cell.setUpCell(detail: item, index: indexPath.row)
    }
    return cell
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    if (indexPath.row > ((viewModel?.feeds?.count ?? 0) - 2)) {
      conainerActivity.isHidden = false
      buttonLoadMore.isHidden = false
    }else {
      conainerActivity.isHidden = true
      buttonLoadMore.isHidden = true
    }
    
    if shouldAnimatedLoading == false { return }
    let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height - 20,
                                                          duration: 1.2,
                                                          delayFactor: 0.05)
    let animator = Animator(animation: animation)
    animator.animate(cell: cell, at: indexPath, in: tableView)
    
  }
}

// MARK: TableView Datasource
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
      cell.setUpImageViewer()
    }
  }
}
