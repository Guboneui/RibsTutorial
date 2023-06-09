//
//  RootInteractor.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import RxSwift
import UIKit
import RxRelay

protocol RootRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
  func attachDetailView()
  func detachDetailView()
}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
  var detailButtonClickedObservable: Observable<Void> { get }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
  
  
  weak var router: RootRouting?
  weak var listener: RootListener?
  
  // MARK: Property
  private let disposeBag = DisposeBag()
  private let viewModelRelay: BehaviorRelay<UIImage>
  private(set) lazy var viewModel: Observable<UIImage> = viewModelRelay.asObservable()
  
  
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(image: UIImage, presenter: RootPresentable) {
    self.viewModelRelay = .init(value: image)
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
    self.bindPresenter()
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  
  // MARK: binding
  private func bindPresenter() {
    presenter.detailButtonClickedObservable
      .bind { [weak self] in
        guard let self else { return }
        self.router?.attachDetailView()
      }.disposed(by: disposeBag)
  }
  
  func attachDetailImageRIB() {
    router?.attachDetailView()
  }
  
  func detachDetailImageRIB() {
    router?.detachDetailView()
  }
  
  
}
