//
//  ViewController.m
//  uikitdyna
//
//  Created by PC on 7/23/16.
//  Copyright © 2016 Randel Smith rs@randelsmith.com. All rights reserved.
//

#import "ViewController.h"
#import "cicleView.h"

@interface ViewController ()
@property (nonatomic, strong)UIDynamicAnimator *animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIView *aView = [cicleView new];
    aView.frame = CGRectMake(200, 0, 20, 20);
    aView.layer.cornerRadius = 10;
    aView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:aView];
    
    NSMutableArray *dropDots = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        UIView *aView = [cicleView new];
        NSUInteger r = arc4random_uniform(200) + 120;
        aView.frame = CGRectMake(r, 0, 18, 18);
        aView.layer.cornerRadius = 9;
        aView.backgroundColor = [UIColor orangeColor];
        
        [self.view addSubview:aView];
        [dropDots addObject:aView];
        
        if (i == 40) {
            aView.backgroundColor = [UIColor blackColor];
        }

    }
    
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:[dropDots arrayByAddingObject:aView]];
    gravityBehavior.magnitude = 1;
    [self.animator addBehavior:gravityBehavior];
    
    
    
    UIDynamicItemBehavior *dobstacles1And2Behavior = [[UIDynamicItemBehavior alloc] initWithItems:[dropDots arrayByAddingObject:aView]];
    dobstacles1And2Behavior.elasticity = .7;
    dobstacles1And2Behavior.charge = 20;
    [self.animator addBehavior:dobstacles1And2Behavior];
    
    
    
    NSMutableArray *dots = [NSMutableArray new];
    for (int i = 5; i < 11; i++) {
        for (int j = 1; j < 6; j++) {
            UIView *aView = [cicleView new];
            if (i % 2 == 0) {
                if (j != 5) {
                    aView.frame = CGRectMake((j * (10 + 60) + 30), i * (10 + 30), 10, 10);
                } else {
                    break;
                }
            } else {
                aView.frame = CGRectMake(j * (10 + 60), i * (10 + 30), 10, 10);
            }
            aView.layer.cornerRadius = 5;
            aView.backgroundColor = [UIColor purpleColor];
            
            [self.view addSubview:aView];
            
            [dots addObject:aView];
        }
    }
    
    
    
    UIDynamicItemBehavior *obstacles1And2Behavior = [[UIDynamicItemBehavior alloc] initWithItems:dots];
    obstacles1And2Behavior.anchored = YES;
    obstacles1And2Behavior.friction = 0;
    obstacles1And2Behavior.elasticity = 0.7;
    [self.animator addBehavior:obstacles1And2Behavior];
    
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:[[dots arrayByAddingObjectsFromArray:dropDots] arrayByAddingObject:aView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
}

@end
