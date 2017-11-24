//
//  ViewController.h
//  Chapter04_DetectingFaces
//
//  Created by Alexander Shishkov on 5/5/13.
//  Copyright (c) 2013 Alexander Shishkov & Kirill Kornyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    cv::CascadeClassifier faceCascade;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
