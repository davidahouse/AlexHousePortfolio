//
//  ViewController.m
//  AlexHousePortfolio
//
//  Created by David House on 3/17/14.
//  Copyright (c) 2014 randomaccident. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"
#import "ZoomOutSegue.h"
#import "ZoomInSegue.h"
#import "TransitionDelegate.h"

@interface ViewController ()

#pragma mark - Properties
@property (nonatomic,strong) NSArray *sections;
@property (nonatomic,strong) NSDictionary *selectedSection;
@property (nonatomic, strong) TransitionDelegate *transitionController;
@property (nonatomic,assign) CGRect selectedFrame;

#pragma mark - IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *layer1Image;
@property (weak, nonatomic) IBOutlet UIImageView *layer2Image;
@property (weak, nonatomic) IBOutlet UIImageView *layer3Image;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load in the sections
    NSData *rawData = nil;
    
    for (NSBundle *bundle in [NSBundle allBundles]) {
        
        NSString *dataPath = [bundle pathForResource:@"portfolio" ofType:@"json"];
        if ( dataPath ) {
            NSLog(@"dataPath: %@",dataPath);
            rawData = [NSData dataWithContentsOfFile:dataPath];
        }
    }
    
    if ( rawData ) {
        
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:&error];
        if ( jsonObject == nil ) {
            NSLog(@"error loading json: %@",[error localizedDescription]);
        }

        self.sections = (NSArray *)jsonObject[@"sections"];
        [self loadSections];
    }
    
    self.transitionController = [[TransitionDelegate alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)returnToMainView:(UIStoryboardSegue *)segue {
    
}

#pragma mark - Private Methods
- (void)loadSections {
    
    for ( NSDictionary *section in self.sections ) {
    
        UIImageView *thumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:section[@"thumbnail"]]];
        NSArray *frameParts = [section[@"viewFrame"] componentsSeparatedByString:@","];
        CGRect thumbFrame = CGRectMake([frameParts[0] floatValue], [frameParts[1] floatValue], [frameParts[2] floatValue], [frameParts[3] floatValue]);
        
        thumb.frame = thumbFrame;
        [self.view addSubview:thumb];
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.view];
    
    for ( NSDictionary *section in self.sections ) {
        
        NSArray *frameParts = [section[@"viewFrame"] componentsSeparatedByString:@","];
        CGRect thumbFrame = CGRectMake([frameParts[0] floatValue], [frameParts[1] floatValue], [frameParts[2] floatValue], [frameParts[3] floatValue]);
        if ( CGRectContainsPoint(thumbFrame, location) ) {
            
            NSLog(@"image touched with frame: %@",section[@"viewFrame"]);
            self.selectedSection = section;
            self.selectedFrame = thumbFrame;
            self.transitionController.referenceFrame = thumbFrame;
            [self performSegueWithIdentifier:@"ToDetailsViewController" sender:self];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"ToDetailsViewController"] ) {
        DetailsViewController *dvc = (DetailsViewController *)segue.destinationViewController;
        dvc.transitioningDelegate = self.transitionController;
        dvc.section = self.selectedSection;
    }
    
    
    if ( [segue isKindOfClass:[ZoomOutSegue class]] ) {
        
        NSArray *frameParts = [self.selectedSection[@"viewFrame"] componentsSeparatedByString:@","];
        CGRect thumbFrame = CGRectMake([frameParts[0] floatValue], [frameParts[1] floatValue], [frameParts[2] floatValue], [frameParts[3] floatValue]);
        ((ZoomOutSegue *)segue).referencePoint = CGPointMake(thumbFrame.origin.x + (thumbFrame.size.width / 2),
            thumbFrame.origin.y + (thumbFrame.size.height / 2));
        
        
    }
    
}

/*
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    
    ZoomInSegue *segue = [[ZoomInSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];

    NSArray *frameParts = [self.selectedSection[@"viewFrame"] componentsSeparatedByString:@","];
    CGRect thumbFrame = CGRectMake([frameParts[0] floatValue], [frameParts[1] floatValue], [frameParts[2] floatValue], [frameParts[3] floatValue]);
    segue.targetPoint = CGPointMake(thumbFrame.origin.x + (thumbFrame.size.width / 2),
                                                         thumbFrame.origin.y + (thumbFrame.size.height / 2));
    return segue;
}
*/
@end
