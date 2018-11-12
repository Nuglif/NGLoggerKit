//
//  FailableDecodable.swift
//  NGTools
//
//  Created by Werck, Ayrton on 2018-11-05.
//  Copyright © 2018 Nuglif. All rights reserved.
//

public struct FailableDecoder<Base: Decodable> : Decodable {

    public let base: Base?

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        base = try? container.decode(Base.self)
    }
}
