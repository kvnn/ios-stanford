//
//  FaceView.m
//  Happiness
//
//  Created by icrossing on 11/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawCircleAtPoint: (CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context 
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

#define DEFAULT_SCALE 0.90
 
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width / 2;
    if (self.bounds.size.height / 2 < size) size = self.bounds.size.height / 2;
    
    size *= DEFAULT_SCALE;

    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    // draw face (circle)
    // draw eyes (2 circles)
    // no nose
    // draw mouth
}

@end
