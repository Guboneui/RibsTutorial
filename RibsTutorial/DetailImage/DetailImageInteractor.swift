//
//  DetailImageInteractor.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import RxSwift
import RxRelay
import UIKit

protocol DetailImageRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailImagePresentable: Presentable {
  var listener: DetailImagePresentableListener? { get set }
  var detachObservable: Observable<Void> { get }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailImageListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
  func detachDetailImageRIB()
  func attachDetailImageRIB()
}

final class DetailImageInteractor:
  PresentableInteractor<DetailImagePresentable>,
  DetailImageInteractable,
  DetailImagePresentableListener
{
  
  weak var router: DetailImageRouting?
  weak var listener: DetailImageListener?
  
  private let disposeBag = DisposeBag()
  private let viewModelRelay: BehaviorRelay<UIImage>
  private(set) lazy var viewModel: Observable<UIImage> = viewModelRelay.asObservable()
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(image: UIImage, presenter: DetailImagePresentable) {
    viewModelRelay = .init(value: image)
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    self.bindPresenter()
    // TODO: Implement business logic here.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  private func bindPresenter() {
    presenter.detachObservable
      .bind { [weak self] _ in
        guard let self else { return }
        self.listener?.detachDetailImageRIB()
      }.disposed(by: disposeBag)
  }
}
