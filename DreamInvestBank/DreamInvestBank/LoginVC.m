

#import "LoginVC.h"
#import <MapKit/MapKit.h>
#import "AddressAnnotation.h"

@interface LoginVC ()
@property (strong, nonatomic) IBOutlet MKMapView *map;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CLLocationCoordinate2D  ctrpoint;
    ctrpoint.latitude = 48.8534100;
    ctrpoint.longitude = 2.3488000;
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:ctrpoint];
    [[self map] addAnnotation:addAnnotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize userId = _userId;


@end
