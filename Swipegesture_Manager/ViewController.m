//
//  ViewController.m
//  Swipegesture_Manager
//
//  Created by haosy on 2017/10/17.
//  Copyright © 2017年 haosy. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"

#define K_OrginalY          [UIScreen mainScreen].bounds.size.height - 50
#define K_OrginalMiddleY    [UIScreen mainScreen].bounds.size.height - 55

#define K_ArraiveY  64
#define K_ArraiveMiddleY  70

@interface ViewController ()<UIGestureRecognizerDelegate>

//拖动手势
@property (nonatomic,strong)UIPanGestureRecognizer *panGesture;
//轻扫手势
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeUp;
@property (nonatomic,strong)UISwipeGestureRecognizer *swipeDown;

@property (nonatomic,strong)UIView *frontView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.frontView];
   
    CGRect frame = self.frontView.frame;
    frame.origin.y = K_OrginalY;
    self.frontView.frame = frame ;
}




- (UIView *)frontView
{
    if (!_frontView) {
        _frontView = [UIView new];
        _frontView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
        _frontView.backgroundColor = [UIColor redColor];
        _frontView.layer.cornerRadius = 10.0f;
        
//        _swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
//        _swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//
//        [_frontView addGestureRecognizer:_swipeUp];
//
//        _swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
//        _swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//
//        [_frontView addGestureRecognizer:_swipeDown];
        
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(pan:)];
        _panGesture.delegate = self;
        [_frontView addGestureRecognizer:_panGesture];
        
        
        
    }
    return _frontView;
}

#pragma mark -- 拖动手势
- (void)pan:(UIPanGestureRecognizer *)pan
{
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint startPoint = [pan translationInView:self.frontView];
            NSLog(@"startPoint = %@",NSStringFromCGPoint(startPoint));
        }
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [pan translationInView:self.frontView];
            NSLog(@"changePoint = %@",NSStringFromCGPoint(changePoint));
            
            CGRect frame = self.frontView.frame;
          
            if (changePoint.y < 0) {//向上滑动
                
                if (frame.origin.y <= K_OrginalY && frame.origin.y  >K_OrginalMiddleY  ) {
                    frame.origin.y -= 1;
                    self.frontView.frame = frame;
                }else {
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGRect frame = self.frontView.frame;
                        frame.origin.y = K_ArraiveY;
                        self.frontView.frame = frame ;
                    }];
                }
                
            }else{//向下滑动
                
                if (frame.origin.y >= K_ArraiveY && frame.origin.y  < K_ArraiveMiddleY  ) {
                    frame.origin.y += 1;
                    self.frontView.frame = frame;
                }else {
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGRect frame = self.frontView.frame;
                        frame.origin.y = K_OrginalY;
                        self.frontView.frame = frame ;
                    }];
                }
            }
            
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint endPoint = [pan translationInView:self.frontView];
            NSLog(@"endPoint = %@",NSStringFromCGPoint(endPoint));
             CGRect frame = self.frontView.frame;
            if (endPoint.y < 0) {//向上滑动
                if (frame.origin.y < K_OrginalMiddleY) {
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGRect frame = self.frontView.frame;
                        frame.origin.y = K_ArraiveY;
                        self.frontView.frame = frame ;
                    }];
                }else{
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGRect frame = self.frontView.frame;
                        frame.origin.y = K_OrginalY;
                        self.frontView.frame = frame ;
                    }];
                    
                }
            }else{//向下滑动
                if (frame.origin.y > K_ArraiveMiddleY) {
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGRect frame = self.frontView.frame;
                        frame.origin.y = K_OrginalY;
                        self.frontView.frame = frame ;
                    }];
                }else{
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGRect frame = self.frontView.frame;
                        frame.origin.y = K_ArraiveY;
                        self.frontView.frame = frame ;
                    }];
                    
                }
            }
            
        }
            break;
        default:
            break;
    }
}


#pragma mark -- 轻扫手势
- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    //如果向上滑动
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        
        if (self.frontView.frame.origin.y > K_ArraiveY) {
            [UIView animateWithDuration:0.4 animations:^{
               
                CGRect frame = self.frontView.frame;
                frame.origin.y = K_ArraiveY;
                self.frontView.frame = frame ;
            }];
        }
        
    }else if (UISwipeGestureRecognizerDirectionDown){//如果向下
        
        if (self.frontView.frame.origin.y <= K_ArraiveY) {
            [UIView animateWithDuration:0.4 animations:^{
                
                CGRect frame = self.frontView.frame;
                frame.origin.y = K_OrginalY;
                self.frontView.frame = frame ;
            }];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
