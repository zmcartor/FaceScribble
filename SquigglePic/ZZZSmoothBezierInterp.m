//  ZZZSmoothBezierInterp.m
//
//  Created by zm on 10/22/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "ZZZSmoothBezierInterp.h"

@interface ZZZSmoothBezierInterp ()

@end

@implementation ZZZSmoothBezierInterp {
    UIBezierPath *currentPath;
    UIImage *incrementalImage;
    CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    uint ctr;
    NSMutableDictionary *savedPaths;
    UIGestureRecognizer *moveRecognizer;
    UILongPressGestureRecognizer *longPress;
    int mode;
}

- (void)attachRecognizers {
    mode = 0;
    [self setMultipleTouchEnabled:NO];
    [self setBackgroundColor:[UIColor whiteColor]];
    savedPaths = [[NSMutableDictionary alloc] init];
    
    // IMPORTANT means view will keep listening after first touch is detected.
    [self setMultipleTouchEnabled:YES];
    
    /* single tap not needed
     UITapGestureRecognizer *taprecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
     taprecog.numberOfTapsRequired = 1;
     [self addGestureRecognizer:taprecog];
     */
    
    UITapGestureRecognizer *doubleTaprecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTaprecog.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTaprecog];
    
    // cache the background view into placeholder image.
    // all paths are added to this image incrementally as an image cache
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"linedpaper"]] setFill];
    [rectpath fill];
    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.strokeColor = [UIColor blackColor];
}

- (void)tap:(UITapGestureRecognizer *)recog {
    NSLog(@"ONE TAP!");
    
}

- (void)doubleTap:(UITapGestureRecognizer *)recog {
    NSLog(@"Double tap!");
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

- (void)drawRect:(CGRect)rect {
    [incrementalImage drawInRect:rect];
    if (currentPath){
        [self.strokeColor setFill];
        [self.strokeColor setStroke];
        [currentPath stroke];
    }
}

// Called after each of the gesture recognizers have ended.
// Drawing could be better abstracted into Pan-Drawing, LongPress/Pan-Move recognizers.

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(currentPath){
        [self cacheDrawingActivity:currentPath];
    }
    [self setNeedsDisplay];
    currentPath = nil;
    ctr = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    ctr = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
    currentPath = [self createNewPath];
}

//Every FOUR points we interpolate a Bezier path. Smooth this shiz out between our paths!
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (mode != 0){
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    ctr++;
    pts[ctr] = p;
    
    // correct the bad bezier curve and smooth out the joining of two curves
    // in this case we collect FIVE points instead of four and then adjust our ending point (3)]
    // these are our 4 points for current curve +1 for beginning of the next curve.
    if (ctr == 4) {
        // Move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        [currentPath moveToPoint:pts[0]];
        [currentPath addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]]; // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        [self setNeedsDisplay];
        
        // replace points from line smoothing and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

// TODO test that the lines are drown into the view !!
- (void)cacheDrawingActivity:(UIBezierPath *)latestActivity {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [incrementalImage drawAtPoint:CGPointZero];

    // stroke in with current selected color
    [self.strokeColor setStroke];
    [latestActivity stroke];
    
    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

#pragma Mark - UIBezier Path Datasource methods. TODO abstract these into separate class w protocol
- (UIBezierPath *)createNewPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:2.0];
    return path;
}

@end
