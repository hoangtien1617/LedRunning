//
//  ViewController.m
//  RunningLed
//
//  Created by Hoàng Tiến on 9/29/15.
//  Copyright © 2015 Hoàng Tiến. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    int _numberOfBall;
    int _numberOfBallX;
    int _numberOfBallY;
    CGFloat _space;
    CGFloat _ballDiameter;
    NSTimer * _timer;
    //int lastOnLed;
    int _ledOnX;
    int _ledOnY;
}

- (void)viewDidLoad {
    _margin = 40.0;
    _ballDiameter   = 24.0;
    _numberOfBallX = 10 ;
    _numberOfBallY = 11;
    _numberOfBall = _numberOfBallX * _numberOfBallY;
    //lastOnLed   = -1 ;
    _ledOnX = -1;
    _ledOnY = _numberOfBall -1 ;
    [super viewDidLoad];
    [self checkSizeScr];
    [self numberOfBall];
    [self drawRowOfBall:_numberOfBallX and:_numberOfBallY andTag:100];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(runningLed) userInfo:nil repeats:true
              ];

}


-(void)runningLed {
    
    [self turnOffLed:_ledOnX];
    
    if(_ledOnX!=_numberOfBall-1){
        _ledOnX++;
    }else{
        _ledOnX=0;
    }
    [self turnOnLed:_ledOnX];
    
   if(_ledOnY!=_numberOfBall-1){      //2 ball từ dưới lên trên
        [self turnOffLed:_ledOnY];
    }
    if(_ledOnY!=0){
        _ledOnY--;
    }else{
        _ledOnY=_numberOfBall-1;
    }
    [self turnOnLed:_ledOnY];
    
}
-(void)turnOnLed : (int) index{
    UIView *view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView *ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
    
}
-(void)turnOffLed : (int) index{
    UIView *view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView *ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"orange"];
    }

    
}
-(CGFloat) spaceBetweenBall : (int)n{
    return (self.view.bounds.size.width - 2 * _margin) / (n-1);
    
}

-(void) numberOfBall {
    bool stop = false;
    int n= 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBall : n];
        if (space < _ballDiameter) {
            stop = true;
            
        }else{
            NSLog(@"Number of ball %d, space between ball %3.0f",n,space);
        }n++;
    }
    
}

-(void) placeBallOnScr : (CGFloat) x  andY
                       : (CGFloat) y withTag
                       : (int)tag
{
    
    UIImageView *ball = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"orange"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    NSLog(@"%d",tag);
}
-(void)checkSizeScr {
    NSLog(@"%3.0f x %3.0f",self.view.bounds.size.width,self.view.bounds.size.height);
}
-(void) drawRowOfBall : (int) numberOfBallsOnX and : (int)numberOfBallsOnY andTag :(int)tag
{
    CGFloat spacex = [self spaceBetweenBall:numberOfBallsOnX];
    CGFloat spacey = [self spaceBetweenBall:numberOfBallsOnY];

    for (int i = 0; i<numberOfBallsOnX; i++)
        for (int j = 0; j< numberOfBallsOnY; j++)
        {
            [self placeBallOnScr:_margin + i * spacex
                            andY:_margin + j * spacey
                         withTag:tag++];
                              // (j+1)*_numberOfBallX -i +100]; từ trái qua phải
            

             }
             
            
}

@end
