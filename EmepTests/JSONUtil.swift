//
//  JSONUtil.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

public enum JSONUtilError: Error {
    case resourceNotFound
    case dataParsing(Error)
    case jsonParsing(Error)
}

final class JSONUtil {
    private init() { fatalError("\(Self.Type.self) is not meant to be instantiated") }

    private static func load(forBunle bundle: Bundle, resourceName: String) -> Result<Data, JSONUtilError> {
        // let bundle = Bundle(for: type(of: testClass))
        let fileUrl = bundle.url(forResource: resourceName, withExtension: "json")
        guard let url = fileUrl else {
            return .failure(.resourceNotFound)
        }
        do {
            let data = try Data(contentsOf: url)
            return .success(data)
        } catch let error {
            return .failure(.dataParsing(error))
        }
    }
    
    static func loadJSON<T>(forBunle bundle: Bundle, resourceName: String) -> Result<T, JSONUtilError> where T: Decodable {
        let resultData = load(forBunle: bundle, resourceName: resourceName)
        switch resultData {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch let error {
                return .failure(.jsonParsing(error))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
