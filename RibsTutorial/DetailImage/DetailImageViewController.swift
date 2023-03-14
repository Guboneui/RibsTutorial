//
//  DetailImageViewController.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import RxSwift
import RxRelay
import UIKit

protocol DetailImagePresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  var viewModel: Observable<UIImage> { get }
}

final class DetailImageViewController: UIViewController, DetailImagePresentable, DetailImageViewControllable {
  
  
  private let imageView = UIImageView().then {
    $0.layer.masksToBounds = true
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.blue.cgColor
  }
  
  private let closeButton = UIButton(type: .system).then {
    $0.setTitle("Close", for: .normal)
  }
  
  
  private let detachRelay: PublishRelay<Void> = .init()
  lazy var detachObservable: Observable<Void> = detachRelay.asObservable()
  
  weak var listener: DetailImagePresentableListener?
  private let disposeBag = DisposeBag()
  
  
  
  // MARK: VC LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
    self.setupGestures()
    self.bind(to: listener)
  }
  
  // MARK: Method
  private func setupViews() {
    self.view.backgroundColor = .brown
    self.view.addSubview(imageView)
    self.view.addSubview(closeButton)
    
    imageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(200)
    }
    
    closeButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalToSuperview()
    }
  }
  
  private func bind(to listener: DetailImagePresentableListener?) {
    listener?.viewModel
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] image in
        guard let self else { return }
        self.imageView.image = image
      }).disposed(by: disposeBag)
  }
  
  private func setupGestures() {
    self.closeButton.rx.tap
      .bind(to: detachRelay)
      .disposed(by: disposeBag)
  }
  
}
