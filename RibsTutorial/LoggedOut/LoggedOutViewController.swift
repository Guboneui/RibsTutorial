//
//  LoggedOutViewController.swift
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

protocol LoggedOutPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func didTapClose()
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
  
  // MARK: UI
  private let titleLabel = UILabel().then {
    $0.text = "LoggedOutViewController"
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.textAlignment = .center
  }
  
  private let button = UIButton(type: .system).then {
    $0.setTitle("Clicked", for: .normal)
  }
  
  // MARK: Property
  weak var listener: LoggedOutPresentableListener?
  private let disposeBag = DisposeBag()
  
  
  // MARK: VC LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
    self.setupGestures()
  }
  
  // MARK: Method
  private func setupViews() {
    self.view.backgroundColor = .gray
    self.view.addSubview(titleLabel)
    self.view.addSubview(button)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview()
    }
    
    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func setupGestures() {
    self.button.rx.tap
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .bind { [weak self] in
        guard let self else { return }
        self.listener?.didTapClose()
      }.disposed(by: disposeBag)
  }
  
}
