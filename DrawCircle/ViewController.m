//
//  ViewController.m
//  DrawCircle
//
//  Created by foreveross－bj on 15/6/8.
//  Copyright (c) 2015年 foreveross－bj. All rights reserved.
//

#import "ViewController.h"
#import "VoiceView.h"

@interface ViewController ()
@property (nonatomic, strong) VoiceView *voiceView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.voiceView = [[VoiceView alloc] initWithFrame:CGRectMake(100, 100, 90, 90)];
    _voiceView.color = [UIColor redColor];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_voiceView];
    
}
- (IBAction)start:(id)sender {
    [_voiceView startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
