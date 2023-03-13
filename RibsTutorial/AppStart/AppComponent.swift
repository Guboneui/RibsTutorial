//
//  AppComponent.swift
//  RibsTutorial
//
//  Created by 구본의 on 2023/03/14.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
  init() {
    super.init(dependency: EmptyComponent())
  }
}
