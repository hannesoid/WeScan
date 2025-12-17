//
//  AdaptiveThreshold.metal
//  WeScan
//
//  Created by Assistant on 12/17/2025.
//
#include <metal_stdlib>
using namespace metal;

// Core Image Metal Kernel: Color kernel that performs a smooth threshold on luminance
extern "C" {
    namespace coreimage {

        float lumaFromRGB(float3 rgb) {
            // Rec. 709 coefficients
            return dot(rgb, float3(0.2126, 0.7152, 0.0722));
        }

        // Core Image color kernel signature in Metal
        float4 adaptiveThresholdKernel(
            sampler s,
            texture2d<float, access::sample> src,
            float inputEdge0,
            float inputEdge1,
            float2 destCoord
        ) {
            float2 size = float2(src.get_width(), src.get_height());
            float2 uv = destCoord / size;
            float4 pixel = src.sample(s, uv);
            float luma = lumaFromRGB(pixel.rgb);
            // smoothstep(edge0, edge1, x)
            float t = smoothstep(inputEdge0, inputEdge1, luma);
            return float4(t, t, t, 1.0);
        }

    }
}
