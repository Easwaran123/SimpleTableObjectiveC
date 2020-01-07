//
//  ViewController.m
//  customSimpeTable
//
//  Created by v-20 on 7/3/17.
//  Copyright © 2017 VividInfotech. All rights reserved.
//

#import "ViewController.h"<UITableViewDataSource,UITableViewDelegate>
#import "customTableViewCell.h"

@interface ViewController ()
    {
        NSArray *allparts;
        NSMutableArray *allTitle;
        NSMutableArray *allBody;
        
       
    }
    @property (strong, nonatomic) IBOutlet UITableView *tableLoadView;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allTitle =[[NSMutableArray alloc ]init];
    allBody =[[NSMutableArray alloc ]init];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/posts"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       NSLog(@"the datata%@", json);
        
        allparts = [[NSArray alloc]initWithArray:json];
        [self getData:allparts];
        [self.tableLoadView reloadData];
      NSLog(@"the dataxxxxxxxxta%lu", (unsigned long)allparts.count);
       }];
    
    [dataTask resume];
}

#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [allparts count];
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        static NSString *cellIdentifier = @"customcell";
        customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.lblTitle.text = [allTitle objectAtIndex:indexPath.row];
        cell.lblBody.text = [allBody objectAtIndex:indexPath.row];
        
        return cell;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

    -(void)getData:(NSArray *) ary
    {
        for (int i=0; i<ary.count; i++) {
                       
            [allTitle addObject:[[ary objectAtIndex:i] valueForKey:@"title"]];
            [allBody addObject:[[ary objectAtIndex:i] valueForKey:@"body"]];
            
        }
    }
@end
