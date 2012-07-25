//
//  SimpleTableViewController.m
//  SimpleTable
//
//  Created by Minh Vu Nhat on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleTableViewController.h"
#import "SimpleTableCell.h"
#import "OS.h"

@implementation SimpleTableViewController

{
    NSMutableArray *tableDataMu;
    NSArray *tableData;
    NSArray *preptimeData;
    NSArray *thumbnails;
    NSArray *OSs;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize table data
    
    //tableData = [NSArray arrayWithObjects:@"DTVD", @"Karo", @"Myuusha", nil];
    tableDataMu = [NSMutableArray arrayWithObjects:@"Kara", @"T-ara", @"SNSD", nil];
    preptimeData = [NSArray arrayWithObjects:@"10 min", @"25 min", @"15 min", nil];
    thumbnails = [NSArray arrayWithObjects:@"snow_leopard.png", @"MoutainLion.jpg", @"Lion.jpg", nil];
    
    // Determine plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
    // Load content
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    tableData = [dict objectForKey:@"RecipeName"];
    preptimeData = [dict objectForKey:@"PrepTime"];
    thumbnails = [dict objectForKey:@"Thumbnail"];
    
    //OS Init
    OS *OS1 = [OS new];
    OS1.name = [[dict objectForKey:@"RecipeName"] objectAtIndex:0 ];
    OS1.prepTime = [[dict objectForKey:@"PrepTime"] objectAtIndex:0 ];
    OS1.imageFile = [[dict objectForKey:@"Thumbnail"] objectAtIndex:0 ];
    
    OS *OS2 = [OS new];
    OS2.name = [[dict objectForKey:@"RecipeName"] objectAtIndex:1 ];
    OS2.prepTime = [[dict objectForKey:@"PrepTime"] objectAtIndex:1 ];
    OS2.imageFile = [[dict objectForKey:@"Thumbnail"] objectAtIndex:1 ];

    OS *OS3 = [OS new];
    OS3.name = [[dict objectForKey:@"RecipeName"] objectAtIndex:2 ];
    OS3.prepTime = [[dict objectForKey:@"PrepTime"] objectAtIndex:2 ];
    OS3.imageFile = [[dict objectForKey:@"Thumbnail"] objectAtIndex:2 ];

    OSs = [NSArray arrayWithObjects: OS1, OS2, OS3, nil];
}

// numberOfRowsInSection
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [OSs count];
}

// cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell = [nib objectAtIndex:0];
    }
    //cell.nameLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //cell.timeLabel.text = [preptimeData objectAtIndex:indexPath.row];
    //cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
    
    OS *OS = [OSs objectAtIndex:indexPath.row ];
    cell.nameLabel.text = OS.name;
    cell.imageView.image = [UIImage imageNamed:OS.imageFile];
    cell.prepTimeLabel.text = OS.prepTime;
    return cell;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
} 

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Now ur day!" message:[tableData objectAtIndex:indexPath.row] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //Display Alert Message
    //[messageAlert show];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableDataMu removeObjectAtIndex:indexPath.row];
    //[tableData delete:indexPath.self];
    [tableView reloadData];
}

@end
