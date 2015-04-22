//
//  JPSThumbnailAnnotationView.m
//  JPSThumbnailAnnotationView
//
//  Created by Jean-Pierre Simard on 4/21/13.
//  Copyright (c) 2013 JP Simard. All rights reserved.
//

@import QuartzCore;
#import "JPSThumbnailAnnotationView.h"
#import "JPSThumbnail.h"

NSString * const kJPSThumbnailAnnotationViewReuseID = @"JPSThumbnailAnnotationView";

static CGFloat const kJPSThumbnailAnnotationViewStandardWidth     = 36.0f;
static CGFloat const kJPSThumbnailAnnotationViewStandardHeight    = 46.0f;
static CGFloat const kJPSThumbnailAnnotationViewExpandOffset      = 200.0f;
static CGFloat const kJPSThumbnailAnnotationViewVerticalOffset    = 34.0f;
static CGFloat const kJPSThumbnailAnnotationViewAnimationDuration = 0.25f;

@interface JPSThumbnailAnnotationView ()

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) ActionBlock disclosureBlock;

@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) UIButton *disclosureButton;
@property (nonatomic, assign) JPSThumbnailAnnotationViewState state;

@end

@implementation JPSThumbnailAnnotationView
{
    UIButton *button;
}
#pragma mark - Setup

- (id)initWithAnnotation:(id<MKAnnotation>)annotation {
    self = [super initWithAnnotation:annotation reuseIdentifier:kJPSThumbnailAnnotationViewReuseID];
    
    if (self) {
        self.canShowCallout = NO;
        self.frame = CGRectMake(0, 0, kJPSThumbnailAnnotationViewStandardWidth, kJPSThumbnailAnnotationViewStandardHeight);
        self.backgroundColor = [UIColor clearColor];
        self.centerOffset = CGPointMake(0, -kJPSThumbnailAnnotationViewVerticalOffset+10);
        
        _state = JPSThumbnailAnnotationViewStateCollapsed;
        
        [self setupView];
    }
    
    return self;
}

- (void)setupView {
    [self setupImageView];
    [self setLayerProperties];
    [self setDetailGroupAlpha:0.0f];
}

- (void)setupImageView {
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(didTapDisclosureButton)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"pinMap.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0f, 0.0f, 36.0f, 46.0f);
    [self addSubview:button];
}


- (void)setLayerProperties {
    _bgLayer = [CAShapeLayer layer];
    CGPathRef path = [self newBubbleWithRect:self.bounds];
    _bgLayer.path = path;
    CFRelease(path);
    _bgLayer.fillColor = [UIColor clearColor].CGColor;
    
//    _bgLayer.shadowColor = [UIColor blackColor].CGColor;
//    _bgLayer.shadowOffset = CGSizeMake(0.0f, 3.0f);
//    _bgLayer.shadowRadius = 2.0f;
//    _bgLayer.shadowOpacity = 0.5f;
    
    _bgLayer.masksToBounds = NO;
    
    [self.layer insertSublayer:_bgLayer atIndex:0];
}

#pragma mark - Updating

- (void)updateWithThumbnail:(JPSThumbnail *)thumbnail {
    self.coordinate = thumbnail.coordinate;
    self.titleLabel.text = thumbnail.title;
    self.subtitleLabel.text = thumbnail.subtitle;
    self.imageView.image = thumbnail.image;
    [button setImage:thumbnail.image forState:UIControlStateNormal];
    self.disclosureBlock = thumbnail.disclosureBlock;
}

#pragma mark - JPSThumbnailAnnotationViewProtocol

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView {
    // Center map at annotation point
    [mapView setCenterCoordinate:self.coordinate animated:YES];
}

- (void)didDeselectAnnotationViewInMap:(MKMapView *)mapView {
}

#pragma mark - Geometry

- (CGPathRef)newBubbleWithRect:(CGRect)rect {
    CGFloat stroke = 1.0f;
	CGFloat radius = 7.0f;
	CGMutablePathRef path = CGPathCreateMutable();
	CGFloat parentX = rect.origin.x + rect.size.width/2.0f;
	
	// Determine Size
	rect.size.width -= stroke + 14.0f;
	rect.size.height -= stroke + 29.0f;
	rect.origin.x += stroke / 2.0f + 7.0f;
	rect.origin.y += stroke / 2.0f + 7.0f;
    
	// Create Callout Bubble Path
	CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y + radius);
	CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height - radius);
	CGPathAddArc(path, NULL, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI, M_PI_2, 1);
	CGPathAddLineToPoint(path, NULL, parentX - 14.0f, rect.origin.y + rect.size.height);
	CGPathAddLineToPoint(path, NULL, parentX, rect.origin.y + rect.size.height + 14.0f);
	CGPathAddLineToPoint(path, NULL, parentX + 14.0f, rect.origin.y + rect.size.height);
	CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
	CGPathAddArc(path, NULL, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI_2, 0.0f, 1.0f);
	CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + radius);
	CGPathAddArc(path, NULL, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 0.0f, -M_PI_2, 1.0f);
	CGPathAddLineToPoint(path, NULL, rect.origin.x + radius, rect.origin.y);
	CGPathAddArc(path, NULL, rect.origin.x + radius, rect.origin.y + radius, radius, -M_PI_2, M_PI, 1.0f);
	CGPathCloseSubpath(path);
    return path;
}

#pragma mark - Animations

- (void)setDetailGroupAlpha:(CGFloat)alpha {
    self.disclosureButton.alpha = alpha;
    self.titleLabel.alpha = alpha;
    self.subtitleLabel.alpha = alpha;
}

#pragma mark - Disclosure Button

- (void)didTapDisclosureButton {
    if (self.disclosureBlock) self.disclosureBlock();
}
@end
