//
//  PaintView.m
//  MyPainter
//
//  Created by 徐宏 on 2017/4/5.
//  Copyright © 2017年 hankekke. All rights reserved.
//

#import "PaintView.h"
#import "UIImage+screenshot.h"

@interface PaintView ()
//@property (nonatomic, strong) NSMutableArray *pointArray;
//@property (nonatomic, assign) CGContextRef context;
@property (nonatomic, strong) NSMutableArray *pathArray;

@end

@implementation PaintView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSMutableArray *pathPoints in self.pathArray) {
        for (int i = 0; i <pathPoints.count ; i ++) {
            CGPoint point = [pathPoints[i] CGPointValue];
            if (0 == i) {
                CGContextMoveToPoint(context, point.x, point.y);
            } else {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
    }
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:[NSValue valueWithCGPoint:startPoint]];
    [self.pathArray addObject:points];
    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:touch.view];
    NSMutableArray *pathPoints = [self.pathArray lastObject];
    [pathPoints addObject:[NSValue valueWithCGPoint:endPoint]];
    [self setNeedsDisplay];
}

//连线
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];
    NSMutableArray *pathPoints = [self.pathArray lastObject];
    [pathPoints addObject:[NSValue valueWithCGPoint:currentPoint]];
    [self setNeedsDisplay];
}

- (void)removeAllLines {
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

- (void)goBack {
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)save {
    UIImage *image = [UIImage screenShotWithView:self];
    //写进相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSaveImageWithError:contextInfo:), (__bridge void*)self);
}

- (void)image:(UIImage *)image didFinishSaveImageWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"image = %@,error = %@, contextInfo = %@",image,error,contextInfo);
}

- (NSMutableArray *)pathArray {
    if (nil == _pathArray) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

@end
