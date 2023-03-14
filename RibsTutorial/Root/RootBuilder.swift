//
//  RootBuilder.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import UIKit

protocol RootDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
  var image: UIImage { get }
}

final class RootComponent: Component<RootDependency>, DetailImageDependency  {
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
  var image: UIImage { dependency.image }
}


// MARK: - Builder
protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
  
  override init(dependency: RootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> LaunchRouting {
    let component = RootComponent(dependency: dependency)
    let viewController = RootViewController()
    let interactor = RootInteractor(
      image: component.image,
      presenter: viewController
    )
    
    let detailImageBuilder = DetailImageBuilder(dependency: component)
    
    return RootRouter(interactor: interactor,
                      viewController: viewController,
                      detailImageBuilder: detailImageBuilder)
  }
}
