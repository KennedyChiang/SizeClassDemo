//
//  ViewController.m
//  SizeClassDemo
//
//  Created by Chiang ML on 21/11/2017.
//  Copyright © 2017 Chiang ML. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSArray *sharedConstraints;
@property (nonatomic) NSArray *regularConstraints;
@property (nonatomic) NSArray *compactConstraints;
@end

@implementation ViewController

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setBackgroundColor:[UIColor colorWithRed:74.0f/255.0f green:171.0f/255.0f blue:247.0f/255.0f alpha:1]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(37.0f, 30.0f, 300.0f, 265.0f)];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setImage:[UIImage imageNamed:@"Image"]];
    [view addSubview:imageView];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(37.0f, 340.0f, 300.0f, 265.0f)];
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [containerView setBackgroundColor:[UIColor colorWithRed:55.0f/255.0f green:128.0f/255.0f blue:186.0f/255.0f alpha:1]];
    [view addSubview:containerView];
    
    UILabel *locationLabel = [[UILabel alloc] init];
    [locationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [locationLabel setText:@"Cupertino"];
    [locationLabel setTextColor:[UIColor whiteColor]];
    [locationLabel setTextAlignment:NSTextAlignmentCenter];
    [locationLabel setAdjustsFontSizeToFitWidth:YES];
    [locationLabel setMinimumScaleFactor:0.5f];
    [containerView addSubview:locationLabel];
    
    UILabel *temperatureLabel = [[UILabel alloc] init];
    [temperatureLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [temperatureLabel setText:@"28C"];
    [temperatureLabel setTextColor:[UIColor whiteColor]];
    [temperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [temperatureLabel setAdjustsFontSizeToFitWidth:YES];
    [temperatureLabel setMinimumScaleFactor:0.5f];
    [containerView addSubview:temperatureLabel];

    NSDictionary *views = @{@"view":view,
                            @"imageView":imageView,
                            @"containerView":containerView,
                            @"locationLabel":locationLabel,
                            @"temperatureLabel":temperatureLabel};
    
    _sharedConstraints = [self sharedConstraintsWithViews:views];
    _regularConstraints = [self regularConstraintsWithViews:views];
    _compactConstraints = [self compactConstraintsWithViews:views];
    
    self.view = view;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    NSLog(@"self.traitCollection.horizontalSizeClass = %lu",self.traitCollection.horizontalSizeClass);
    NSLog(@"self.traitCollection.verticalSizeClass = %lu",self.traitCollection.verticalSizeClass);
    NSLog(@"previousTraitCollection.horizontalSizeClass = %lu",previousTraitCollection.horizontalSizeClass);
    NSLog(@"previousTraitCollection.verticalSizeClass = %lu",previousTraitCollection.verticalSizeClass);

    [super traitCollectionDidChange:previousTraitCollection];
    if (![[self.sharedConstraints firstObject] isActive]) {
        [NSLayoutConstraint activateConstraints:self.sharedConstraints];
    }
    if (previousTraitCollection.horizontalSizeClass == UIUserInterfaceSizeClassUnspecified ||
        previousTraitCollection.verticalSizeClass == UIUserInterfaceSizeClassUnspecified) {
        if ([[self.regularConstraints firstObject] isActive]) {
            [NSLayoutConstraint deactivateConstraints:self.regularConstraints];
        }
        if ([[self.compactConstraints firstObject] isActive]) {
            [NSLayoutConstraint deactivateConstraints:self.compactConstraints];
        }
        if (CGRectGetWidth([UIScreen mainScreen].bounds) > CGRectGetHeight([UIScreen mainScreen].bounds)) {
            [NSLayoutConstraint activateConstraints:self.compactConstraints];
        } else {
            [NSLayoutConstraint activateConstraints:self.regularConstraints];
        }
    } else {
        if (previousTraitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
            previousTraitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
            if ([[self.regularConstraints firstObject] isActive]) {
                [NSLayoutConstraint deactivateConstraints:self.regularConstraints];
            }
            [NSLayoutConstraint activateConstraints:self.compactConstraints];
        } else {
            if ([[self.compactConstraints firstObject] isActive]) {
                [NSLayoutConstraint deactivateConstraints:self.compactConstraints];
            }
            [NSLayoutConstraint activateConstraints:self.regularConstraints];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)compactConstraintsWithViews:(NSDictionary *)views {
    UIView *view = [views objectForKey:@"view"];
    UIImageView *imageView = [views objectForKey:@"imageView"];
    UIView *containerView = [views objectForKey:@"containerView"];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:imageView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:0.45
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:imageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:imageView
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeLeadingMargin
                                 multiplier:1
                                   constant:10]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:containerView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:0.5
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:containerView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:[view safeAreaLayoutGuide]
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    
    UILabel *locationLabel = [views objectForKey:@"locationLabel"];
    [locationLabel setFont:[UIFont systemFontOfSize:90 weight:UIFontWeightThin]];
    
    UILabel *temperatureLabel = [views objectForKey:@"temperatureLabel"];
    [temperatureLabel setFont:[UIFont systemFontOfSize:150 weight:UIFontWeightThin]];


    return constraints;
}

- (NSArray *)regularConstraintsWithViews:(NSDictionary *)views {
    UIView *view = [views objectForKey:@"view"];
    UIImageView *imageView = [views objectForKey:@"imageView"];
    UIView *containerView = [views objectForKey:@"containerView"];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:imageView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:0.4
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:imageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:[view safeAreaLayoutGuide]
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:imageView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:[view safeAreaLayoutGuide]
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:20]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:containerView
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:[view safeAreaLayoutGuide]
                                  attribute:NSLayoutAttributeLeading
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:containerView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:imageView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:20]];
    
    UILabel *locationLabel = [views objectForKey:@"locationLabel"];
    [locationLabel setFont:[UIFont systemFontOfSize:150 weight:UIFontWeightThin]];

    UILabel *temperatureLabel = [views objectForKey:@"temperatureLabel"];
    [temperatureLabel setFont:[UIFont systemFontOfSize:250 weight:UIFontWeightThin]];

    return constraints;
}

- (NSArray *)sharedConstraintsWithViews:(NSDictionary *)views {
    UIView *view = [views objectForKey:@"view"];
    UIView *containerView = [views objectForKey:@"containerView"];
    UILabel *locationLabel = [views objectForKey:@"locationLabel"];
    UILabel *temperatureLabel = [views objectForKey:@"temperatureLabel"];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:locationLabel
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:locationLabel
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:10]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:locationLabel
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:temperatureLabel
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:containerView
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:temperatureLabel
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:10]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:temperatureLabel
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:[view safeAreaLayoutGuide]
                                  attribute:NSLayoutAttributeTrailing
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeTrailing
                                 multiplier:1
                                   constant:0]];
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:[view safeAreaLayoutGuide]
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:containerView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    

    return constraints;
}
@end
