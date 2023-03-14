//
//  DetailImageRouter.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs

protocol DetailImageInteractable: Interactable {
    var router: DetailImageRouting? { get set }
    var listener: DetailImageListener? { get set }
}

protocol DetailImageViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DetailImageRouter: ViewableRouter<DetailImageInteractable, DetailImageViewControllable>, DetailImageRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
  override init(
      interactor: DetailImageInteractable,
      viewController: DetailImageViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
