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

protocol RootPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
  
  // MARK: UI
  private let titleLabel = UILabel().then {
    $0.text = "Root View Controller"
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.textAlignment = .center
  }
  
  // MARK: Property
  weak var listener: RootPresentableListener?
  
  // MARK: VC LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    print("🔊[DEBUG]: RootViewController - viewDidLoad")
    self.setupViews()
  }
  
  // MARK: Method
  private func setupViews() {
    self.view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview()
    }
  }
  
  func present(viewController: ViewControllable) {
    viewController.uiviewController.modalPresentationStyle = .formSheet
    self.present(viewController.uiviewController, animated: true, completion: nil)
  }
}
