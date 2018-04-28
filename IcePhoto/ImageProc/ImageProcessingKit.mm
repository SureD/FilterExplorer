//
//  ImageProcessingKit.m
//  IcePhoto
//
//  Created by suredeng on 27/04/2018.
//  Copyright © 2018 IceIce. All rights reserved.
//

#import "ImageProcessingKit.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "HSL.hpp"

static HSL hsl;
@implementation ImageProcessingKit : NSObject

+(UIImage *)getBinaryImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_RGB2GRAY);
    
    cv::Mat bin;
    cv::threshold(gray, bin, 0, 255, cv::THRESH_BINARY | cv::THRESH_OTSU);
    
    UIImage *binImg = MatToUIImage(bin);
    return binImg;
}

+(UIImage *)getHLSImage:(UIImage *)image withColor:(int) color hue:(int)hue saturation:(int) saturation brightness:(int)brightness;
{
    cv::Mat dst;
    cv::Mat src;
    UIImageToMat(image, src);
    hsl.channels[color].hue = hue - 180;
    hsl.channels[color].saturation = saturation - 100;
    hsl.channels[color].brightness = brightness - 100;
    
    hsl.adjust(src, dst);
    
    UIImage *binImg = MatToUIImage(dst);
    return binImg;
}
@end
