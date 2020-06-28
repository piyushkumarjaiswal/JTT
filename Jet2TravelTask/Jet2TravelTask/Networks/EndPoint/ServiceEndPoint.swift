//
//  ServiceEndPoint.swift
//  Jet2TravelTask
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import Foundation

/// Basic Building Environments
enum NetworkEnvironment {
  /// QA release
  case qaEnv
  /// Production release
  case production
  /// Staging release
  case staging
}

/// Servies Api request types
enum ServiceApi {
  /// Getting Post List
  case getPosts(detail: Parameters)
}

extension ServiceApi: EndPointType {
  var path: String {
    return ""
  }
  
  /// Enviroment base url
  var environmentBaseURL: String {
    switch NetworkManager.environment {
    /// production base url
    case .production: return "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs"
    /// qa base url
    case .qaEnv: return "qa"
    /// staging base url
    case .staging: return "staging"
    }
  }
  /// Base Url for connection
  var baseURL: URL {
    guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
    return url
  }
  /// Rest API methode type
  var httpMethod: HTTPMethod {
    switch self {
    /// For getting country detail should be get type
    case .getPosts:
      return .get
    }
  }
  /// Returning task
  var task: HTTPTask {
    switch self {
    /// For getting country detail should be get type
    case .getPosts(let param):
      return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: param)
    }
  }
  /// Returning header configuration
  var headers: HTTPHeaders? {
    return nil
  }
}
