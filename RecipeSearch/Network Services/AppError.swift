//
//  AppError.swift
//  AstronomyPhotos
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

enum AppError: Error {
  case badURL(String) // associated value
  case noResponse
  case networkClientError(Error) // no internet connection
  case noData
  case decodingError(Error)
  case badStatusCode(Int) // 404, 500
  case badMimeType(String) // image/jpg
}
