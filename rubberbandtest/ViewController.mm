//
//  ViewController.m
//  rubberbandtest
//
//  Created by Chris Cannam on 09/12/2014.
//  Copyright (c) 2014 Breakfast Quay. All rights reserved.
//

#import "ViewController.h"

#include "rubberband/RubberBandStretcher.h"

using namespace RubberBand;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RubberBandStretcher stretcher(44100, 1);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
