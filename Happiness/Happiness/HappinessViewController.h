//
//  HappinessViewController.h
//  Happiness
//
//  Created by icrossing on 11/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HappinessViewController : UIViewController

@property (nonatomic) int happiness; // 0 is sad, 100 is very happy

@end



// Lecture 6 Notes

// Any time you declare a protocol you're going to want to send yourself as the sender

// We never have an MVC's view span across screens. We create a new MVC.