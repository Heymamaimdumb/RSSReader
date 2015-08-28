//
//  RSSMainVC.m
//  RSSReadert
//
//  Created by Vladislav on 27.08.15.
//  Copyright (c) 2015 Vladislav. All rights reserved.
//

#import "RSSMainVC.h"
#import "AFNetworking.h"
@interface RSSMainVC ()

@end

@implementation RSSMainVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES] ;
    
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/rss/topaudiobooks/limit=10/xml" ];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        self.rssData = [NSMutableData data];
    }
    else { NSLog(@"connection failed");}
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Make sure to set the responseSerializer correctly
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/atom+xml"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
        [XMLParser setShouldProcessNamespaces:YES];
        
        // Leave these commented for now (you first need to add the delegate methods)
        XMLParser.delegate = self;
        [XMLParser parse];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }];
    
    [operation start];
    
    
         // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{

    [_rssData appendData:data];

}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    NSString *result = [[NSString alloc] initWithData:_rssData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    
    self.news = [NSMutableArray array];
    

}

-(void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.currentElement = elementName;
    if([elementName isEqualToString:@"title"])
    {
        self.currentTitle = [NSMutableString string];
        self.pubDate = [NSMutableString string];
    
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([_currentElement isEqualToString:@"title"])
    {
        [_currentTitle appendString:string];
    }
    else if ([_currentElement isEqualToString:@"releaseDate"])
    {
        [_pubDate appendString:string];
    
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"title"]) {
        NSDictionary *newsItem = [NSDictionary dictionaryWithObjectsAndKeys:_currentTitle,@"title", _pubDate,@"releaseDate", nil];
        [_news addObject:newsItem];
       // self.currentTitle = nil;
      //  self.pubDate = nil;
       // self.currentElement = nil;
    }
}
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.tableView reloadData];
    
}

-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@",parseError);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_news count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell != nil)
{
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"] ;
    NSDictionary *newsItem = [_news objectAtIndex:indexPath.row];
    cell.textLabel.text = [newsItem objectForKey:@"title"];
    cell.detailTextLabel.text = [newsItem objectForKey:@"releaseDate"];
}
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
