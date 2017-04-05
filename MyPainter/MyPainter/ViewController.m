//
//  ViewController.m
//  MyPainter
//
//  Created by 韩可可 on 2017/4/5.
//  Copyright © 2017年 hankekke. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet PaintView *paintView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)goBack:(UIButton *)sender {
    [self.paintView goBack];
}
- (IBAction)save:(UIButton *)sender {
    [self.paintView save];
}

- (IBAction)clearScreen:(UIButton *)sender {
    [self.paintView removeAllLines];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
