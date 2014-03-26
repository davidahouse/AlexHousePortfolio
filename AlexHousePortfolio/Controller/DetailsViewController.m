//
//  DetailsViewController.m
//  AlexHousePortfolio
//
//  Created by David House on 3/23/14.
//  Copyright (c) 2014 randomaccident. All rights reserved.
//

#import "DetailsViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DetailsViewController ()

#pragma mark - IBOutlets
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

#pragma mark - Properties
@property (nonatomic,strong) UIImageView *currentImage;
- (IBAction)donePressed:(id)sender;
- (IBAction)videoPressed:(id)sender;

@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for ( NSString *imageName in self.section[@"images"] ) {
    
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        image.frame = CGRectMake(0,0,1024,768);
        [self addHorizontalPagedView:image];
        self.currentImage = image;
    }
        
//    self.scrollerView.minimumZoomScale = 0.25;
//    self.scrollerView.maximumZoomScale = 1.5;
//    self.scrollerView.delegate = self;
    
/*    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self.view addGestureRecognizer:pinchGesture];
 */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)pinchDetected:(UIPinchGestureRecognizer *)recognizer {
    
    if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        
    }
    else if ( recognizer.state == UIGestureRecognizerStateChanged ) {
        
        
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    
    if ( scale <= 0.8 ) {
        
        [self performSegueWithIdentifier:@"BackToMain" sender:self];
        
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.currentImage;
}

- (void)addHorizontalPagedView:(UIView *)newView {
    
    int pages = [self countSubviewsWithTags];
    CGSize viewSize = newView.frame.size;
    CGSize newContentSize = CGSizeMake((pages + 1) * viewSize.width, viewSize.height);
    CGFloat x = pages * viewSize.width;
    CGRect newFrame = CGRectMake(x, 0, newView.frame.size.width, newView.frame.size.height);
    newView.frame = newFrame;
    newView.tag = pages + 1;
    [self.scrollerView addSubview:newView];
    [self.scrollerView setContentSize:newContentSize];
}

- (int)countSubviewsWithTags {
    
    int count = 0;
    
    for ( UIView *view in self.scrollerView.subviews ) {
        if ( view.tag > 0 ) {
            count++;
        }
    }
    
    return count;
}

- (IBAction)donePressed:(id)sender {
    [self performSegueWithIdentifier:@"BackToMain" sender:self];
}

- (IBAction)videoPressed:(id)sender {
    
    if ( self.section[@"videoFile"] ) {
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *moviePath = [bundle pathForResource:self.section[@"videoFile"] ofType:@"mp4"];
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [self presentMoviePlayerViewControllerAnimated:theMovie];
    }
}

@end
