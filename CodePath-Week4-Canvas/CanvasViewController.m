//
//  CanvasViewController.m
//  CodePath-Week4-Canvas
//
//  Created by Calvin Tuong on 2/25/15.
//  Copyright (c) 2015 Calvin Tuong. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (nonatomic, assign) CGPoint trayOriginalCenter;
@property (nonatomic, assign) CGPoint trayUpPosition;
@property (nonatomic, assign) CGPoint trayDownPosition;
@property (nonatomic, strong) UIImageView *faceImageView;
@property (nonatomic, assign) CGPoint faceImageViewOriginalCenter;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    self.trayUpPosition = self.trayView.center;
    self.trayDownPosition = CGPointMake(self.view.center.x, self.view.frame.size.height + 55);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.trayOriginalCenter = self.trayView.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.trayView.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + [sender translationInView:self.view].y);
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [sender velocityInView:self.view];
        
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
            if (velocity.y < 0) {
                // going up
                self.trayView.center = self.trayUpPosition;
            } else {
                // going down
                self.trayView.center = self.trayDownPosition;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (IBAction)onSmileyPan:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = (UIImageView *) sender.view;
        self.faceImageView = [[UIImageView alloc] initWithImage:[imageView image]];
        
        // for panning existing faces
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCreatedFace:)];
        [self.faceImageView addGestureRecognizer:panGesture];
        self.faceImageView.userInteractionEnabled = YES;
        
        
        [self.view addSubview:self.faceImageView];
        self.faceImageView.center = imageView.center;
        self.faceImageView.center = CGPointMake(self.faceImageView.center.x, self.trayView.frame.origin.y + self.faceImageView.center.y);
        self.faceImageViewOriginalCenter = self.faceImageView.center;

        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.faceImageView.center = CGPointMake(self.faceImageViewOriginalCenter.x + [sender translationInView:self.view].x, self.faceImageViewOriginalCenter.y + [sender translationInView:self.view].y);

    } else if (sender.state == UIGestureRecognizerStateEnded) {
 
    }
}

- (void)panCreatedFace:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        // scale face
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
