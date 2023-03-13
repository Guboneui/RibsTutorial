//
//  RootRouter.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  private let loggedOutBuilder: LoggedOutBuildable
  private var loggedOutRouting: Routing?
  
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       loggedOutBuilder: LoggedOutBuilder
  ) {
    self.loggedOutBuilder = loggedOutBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    let router = loggedOutBuilder.build(withListener: interactor)
    self.loggedOutRouting = router
    self.attachChild(router)
    self.viewController.present(viewController: router.viewControllable)
  }
  
  func didTapCloseRoot() {
    print("didTapCloseRoot")
    guard let router = loggedOutRouting else { return }
    viewControllable.uiviewController.dismiss(animated: true)
    detachChild(router)
    self.loggedOutRouting = nil
  }
}
