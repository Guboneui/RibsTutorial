//
//  DetailImageBuilder.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import UIKit

protocol DetailImageDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
  var image: UIImage { get }
}

final class DetailImageComponent: Component<DetailImageDependency>, DetailImageDependency {
  var image: UIImage { dependency.image }
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DetailImageBuildable: Buildable {
  func build(withListener listener: DetailImageListener) -> DetailImageRouting
}

final class DetailImageBuilder: Builder<DetailImageDependency>, DetailImageBuildable {
  
  override init(dependency: DetailImageDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: DetailImageListener) -> DetailImageRouting {
    let component = DetailImageComponent(dependency: dependency)
    let viewController = DetailImageViewController()
    let interactor = DetailImageInteractor(
      image: component.image,
      presenter: viewController
    )
    
    interactor.listener = listener
    return DetailImageRouter(interactor: interactor, viewController: viewController)
  }
}
