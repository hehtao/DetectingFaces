//
//  ViewController.m
//  Chapter04_DetectingFaces
//
//  Created by Alexander Shishkov on 5/5/13.
//  Copyright (c) 2013 Alexander Shishkov & Kirill Kornyakov. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/opencv.hpp>



@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //calculate path to the resource file
    NSString* filename = [[NSBundle mainBundle]
                          pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    //load Haar cascade from the XML file
    faceCascade.load([filename UTF8String]);
    
    //compute path to the resource file
    NSString* filePath = [[NSBundle mainBundle]
                          pathForResource:@"lena" ofType:@"png"];
    //read the image
    UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    //convert UIImage* to cv::Mat
    cv::Mat cvImage;
    UIImageToMat(image, cvImage);
    
    //vector for storing found faces
    std::vector<cv::Rect> faces;
    
    cv::Mat cvGrayImage;
    //convert the image to the one-channel
    cvtColor(cvImage, cvGrayImage, CV_BGR2GRAY);
    //find faces on the image
    faceCascade.detectMultiScale(cvGrayImage, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30,30));
    //draw all found faces
    for(int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& currentFace = faces[i];
        //calculate two corner points to draw a rectangle
        cv::Point upLeftPoint(currentFace.x, currentFace.y);
        cv::Point bottomRightPoint = upLeftPoint + cv::Point(currentFace.width, currentFace.height);
        //draw rectangle around the face
        cv::rectangle(cvImage, upLeftPoint, bottomRightPoint, cv::Scalar(255,0,255), 4, 8, 0);
    }
    //show resulted image on imageView component
    imageView.image = MatToUIImage(cvImage);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
