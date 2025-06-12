//
//  NumberFactClient.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import ComposableArchitecture
import Foundation

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static var liveValue = Self(
        fetch: { number in
            let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

extension DependencyValues {
  var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
