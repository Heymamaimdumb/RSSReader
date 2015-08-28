//
//  RSSMainVC.h
//  RSSReadert
//
//  Created by Vladislav on 27.08.15.
//  Copyright (c) 2015 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSSMainVC : UITableViewController<NSXMLParserDelegate>{
    
    NSMutableArray *_news;
    NSMutableData *_rssData ;
    NSString *_currentElement;
    NSMutableString *_currentTitle;
    NSMutableString *_pubDate;
}

@property (nonatomic,retain) NSMutableData *rssData;
@property (nonatomic,retain) NSString *currentElement;
@property (nonatomic,retain) NSMutableString *currentTitle;
@property (nonatomic,retain) NSMutableString *pubDate;
@property (nonatomic,retain) NSMutableArray *news;
@end
