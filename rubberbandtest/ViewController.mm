//
//  ViewController.m
//  rubberbandtest
//
//  Created by Chris Cannam on 09/12/2014.
//  Copyright (c) 2014 Breakfast Quay. All rights reserved.
//

#import "ViewController.h"

#include "rubberband/RubberBandStretcher.h"

#include <iostream>

#include <sys/time.h>

using std::cerr;
using std::endl;

using namespace RubberBand;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RubberBandStretcher stretcher(44100, 1);
    stretcher.setTimeRatio(1.2);
    stretcher.setPitchScale(1.02);
    
    timeval tv;
    (void)gettimeofday(&tv, 0);

    int countIn = 0, countOut = 0;
    
    int n = 10000;
    for (int i = 0; i < n; ++i) {
        float *buffer = new float[1024];
        for (int j = 0; j < 1024; ++j) {
            buffer[j] = drand48();
        }
        stretcher.process(&buffer, 1024, i == n-1);
        countIn += 1024;
        delete[] buffer;
        int avail = 0;
        while ((avail = stretcher.available()) > 0) {
            countOut += avail;
            float *out = new float[avail];
            stretcher.retrieve(&out, avail);
            delete[] out;
        }
    }

    timeval etv;
    (void)gettimeofday(&etv, 0);
    
    etv.tv_sec -= tv.tv_sec;
    if (etv.tv_usec < tv.tv_usec) {
        etv.tv_usec += 1000000;
        etv.tv_sec -= 1;
    }
    etv.tv_usec -= tv.tv_usec;
    
    double sec = double(etv.tv_sec) + (double(etv.tv_usec) / 1000000.0);
    cerr << "elapsed time: " << sec << " sec, in frames/sec: " << countIn/sec << ", out frames/sec: " << countOut/sec << endl;

    exit(0);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
