//
//  RootViewController.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import Then
import RxGesture

protocol RootPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  var viewModel: Observable<UIImage> { get }
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
  
  // MARK: UI
  private let imageView = UIImageView().then {
    $0.layer.masksToBounds = true
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.blue.cgColor
  }
  
  private let showDetailButton = UIButton(type: .system).then {
    $0.setTitle("Cliked to Detail", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    $0.tintColor = .black
  }
  
  // MARK: Property
  weak var listener: RootPresentableListener?
  private let disposeBag = DisposeBag()
  
  lazy var detailButtonClickedObservable: Observable<Void> = showDetailButton.rx.tap.asObservable()
  
  // MARK: VC LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
    self.bind(to: listener)
  }
  
  // MARK: Method
  private func setupViews() {
    self.view.backgroundColor = .white
    
    self.view.addSubview(imageView)
    self.view.addSubview(showDetailButton)
    
    imageView.snp.makeConstraints { make in
      make.size.equalTo(200)
      make.center.equalToSuperview()
    }
    
    showDetailButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(imageView.snp.bottom).offset(40)
    }
  }
  
  private func bind(to listener: RootPresentableListener?) {
    listener?.viewModel
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] image in
        guard let self else { return }
        self.imageView.image = image
      }).disposed(by: disposeBag)
  }
  
}
