//
//  DetailVC.m
//  RSSReadert
//
//  Created by Vladislav on 04.09.15.
//  Copyright (c) 2015 Vladislav. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *newsLable;


@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsLable.text = self.newsDescription;
    self.navigationItem.title = self.newsText;
    
    self.dateLable.text = self.newsDate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
