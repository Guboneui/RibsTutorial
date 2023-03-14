//
//  RootRouter.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs

protocol RootInteractable: Interactable, DetailImageListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  private let detailImageBuilder: DetailImageBuildable
  private var detailImageRouter: DetailImageRouting?
  
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       detailImageBuilder: DetailImageBuildable
  ) {
    self.detailImageBuilder = detailImageBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
  }
  
  
  func attachDetailView() {
    print("🔊[DEBUG]: attach Detail View")
    let router = detailImageBuilder.build(withListener: interactor)
    self.detailImageRouter = router
    self.attachChild(router)
    self.viewControllable.uiviewController.present(router.viewControllable.uiviewController, animated: true)
  }
  
  func detachDetailView() {
    print("🔊[DEBUG]: detach Detail View")
    guard let router = detailImageRouter else { return }
    viewControllable.uiviewController.dismiss(animated: true)
    detachChild(router)
    self.detailImageRouter = nil
  }
}
