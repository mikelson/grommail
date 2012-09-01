//
//  DrawingView.m
//  GromMail
//
//  Created by kaon on 8/28/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "DrawingView.h"
#import <QuartzCore/QuartzCore.h>

// Private class representing currently drawn vector.

@interface MyPath : NSObject

@property (readonly) UIBezierPath* bezier;
@property (readonly) UITouch* touch; // touch associated with this path
@property (readonly) int size; // UIBezierPath doesn't expose this easily.

- (void)addLineToPoint:(CGPoint)point;
- (CGPoint)currentPoint;
- (void)stroke;
- (void)removeAllPointsBeforeCurrent;

@end

@implementation MyPath

- (id)initWithTouch:(UITouch*)aTouch
{
    self = [super init];
    if (self) {
        _touch = aTouch;
        _bezier = [UIBezierPath bezierPath];
        self.bezier.lineWidth = 10;
        self.bezier.lineCapStyle = kCGLineCapRound;
        self.bezier.lineJoinStyle = kCGLineJoinRound;
        // Assume there's no sub-views that touch could be in...
        [self.bezier moveToPoint: [self.touch locationInView:[self.touch view]]];
        _size++;
    }
    return self;
}

- (void)addLineToPoint:(CGPoint)point
{
    [self.bezier addLineToPoint:point];
    _size++;
    [self.touch.view setNeedsDisplay];
}

- (CGPoint)currentPoint
{
    return [self.bezier currentPoint];
}

- (void)stroke
{
    if (self.size == 1) {
        // UIBezierPath stroke does nothing with one point, so make a circle.
        UIBezierPath* circle = [UIBezierPath bezierPathWithArcCenter:self.bezier.currentPoint
                                                              radius:self.bezier.lineWidth * 0.5
                                                          startAngle:0.0
                                                            endAngle:2.0 * M_PI
                                                           clockwise:FALSE];
        [circle fill];
    } else {
        [self.bezier stroke];
    }
}

- (void)removeAllPointsBeforeCurrent
{
    CGPoint currentPoint = [self.bezier currentPoint];
    [self.bezier removeAllPoints];
    [self.bezier moveToPoint:currentPoint];
}

@end

// Private member variables for DrawingView

@interface DrawingView ()

{
    NSMutableSet* paths;
    UIImage* image;
}

@end

@implementation DrawingView

// Called when inited by nib, the only way DrawingView gets inited.
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        paths = [[NSMutableSet alloc] init];
        
        // Try to read image from file.
        NSString *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/GromMail-drawing.png"];
        image = [UIImage imageWithContentsOfFile:pngPath];
    }
    return self;
}

- (void)dealloc
{
    [self saveViewToImage];
    
    // Save data to a file.
    NSData* serialization = UIImagePNGRepresentation(image);
    NSString *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/GromMail-drawing.png"];
    [serialization writeToFile:pngPath atomically:YES];
}

// Private utility function - render current view into UIImage back buffer.
- (void)saveViewToImage
{
    // Save current in an image
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

/*
 Override some of UIResponder's touch handling methods to respond to the events we want.
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches) {
        MyPath* path = [[MyPath alloc] initWithTouch:touch];
        [paths addObject:path];
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches) {
        // Find the path corresponding with this touch.
        MyPath* path;
        for (path in paths) {
            if (path.touch == touch) {
                break;
            }
        }
        if (path) {
            [path addLineToPoint:[touch locationInView:self]];
        } else {
            NSLog(@"touchesMoved: path not found");
        }
    }
    // TODO: should we flush paths to image when number of points in paths gets too high?
    // Doesn't seem to be a problem on iPad 2...
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Sometime touchesEnded comes after touchesMoved to new point, sometimes it doesn't...
    // So update paths with new locations, then redraw (in backing image), then remove ended paths.
    NSMutableSet* pathsEnded = [[NSMutableSet alloc] init];
    for (UITouch* touch in touches) {
        // Find the path corresponding with this touch.
        MyPath* path;
        for (path in paths) {
            if (path.touch == touch) {
                break;
            }
        }
        if (path) {
            // Sometimes touchesMoved doesn't add last move, so check if we need to add it.
            CGPoint touchLocation = [touch locationInView:touch.view];
            if (CGPointEqualToPoint(touchLocation, [path currentPoint])) {
                [path addLineToPoint:touchLocation];
            }
            [pathsEnded addObject:path];
        } else {
            NSLog(@"touchesEnded: path not found");
        }
    }
    [self saveViewToImage];
    
    // Clear out tracked paths.
    for (UIBezierPath* path in pathsEnded) {
        [paths removeObject:path];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

// perform custom drawing.
- (void)drawRect:(CGRect)rect
{
    UIColor* color = self.colorSource.color;
    [color set];
    // Drawing code
    [image drawAtPoint:self.bounds.origin];
    for (MyPath* path in paths) {
        [path stroke];
    }
}

- (void)erase
{
    BOOL needsDisplay = image || [paths count];
    image = nil;
    [paths makeObjectsPerformSelector:@selector(removeAllPointsBeforeCurrent)];
    if (needsDisplay) {
        [self setNeedsDisplay];
    }
}
@end
