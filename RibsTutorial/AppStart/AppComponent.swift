//
//  AppComponent.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs
import UIKit

class AppComponent: Component<EmptyDependency>, RootDependency {
  var image: UIImage { UIImage(named: "carrot")! }
  
  init() {
    super.init(dependency: EmptyComponent())
  }
}
