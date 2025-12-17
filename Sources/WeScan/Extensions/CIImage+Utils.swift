//
//  CIImage+Utils.swift
//  WeScan
//
//  Created by Julian Schiavo on 14/11/2018.
//  Copyright © 2018 WeTransfer. All rights reserved.
//

import CoreImage
import Foundation
import UIKit

extension CIImage {

    /// Applies an AdaptiveThresholding filter to the image, which enhances the image and makes it completely gray scale
    func applyingAdaptiveThreshold() -> UIImage? {
        // Load Metal library data
        guard let libraryURL: URL = Bundle.module.url(forResource: "default", withExtension: "metallib"),
              let libraryData = try? Data(contentsOf: libraryURL),
              let colorKernel = try? CIColorKernel(functionName: "adaptiveThresholdKernel", fromMetalLibraryData: libraryData) else {
            return nil
        }

        let firstInputEdge = 0.25 as Float
        let secondInputEdge = 0.75 as Float

        let arguments: [Any] = [self, firstInputEdge, secondInputEdge]

        guard let enhancedCIImage = colorKernel.apply(extent: self.extent, arguments: arguments) else { return nil }

        if let cgImage = CIContext(options: nil).createCGImage(enhancedCIImage, from: enhancedCIImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return UIImage(ciImage: enhancedCIImage, scale: 1.0, orientation: .up)
        }
    }
}
