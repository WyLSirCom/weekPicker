//
//  ViewController.m
//  pickerView
//
//  Created by 魏延龙 on 2020/12/16.
//

#import "ViewController.h"
#import "ITDatePicketView.h"

@interface ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"picker" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

-(void)action {
    ITDatePicketView *picker = [ITDatePicketView showDatePickerView];
    picker.title = @"title";
    
    
    
//    UIDatePicker *picker = [[UIDatePicker alloc] init];
//
//    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_GB"];
//    [picker setLocale:locale];
//    picker.datePickerMode = UIDatePickerModeDateAndTime;
//    if (@available(iOS 13.4, *)) {
//        picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
//    }
//    picker.timeZone =[NSTimeZone systemTimeZone];
//    [self.view addSubview:picker];
//    picker.frame = CGRectMake(0, 300, self.view.frame.size.width, 200);
}


@end
