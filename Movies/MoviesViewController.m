//
//  MoviesViewController.m
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import "MoviesViewController.h"
#import "MoviesSectionsCell.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate> {
    __weak IBOutlet UITableView *tblMovies;
    
    NSArray *moviesSections;
}

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    moviesSections = @[@"New in Theatres", @"Popular", @"Highest Rated This Year"];
    
    [tblMovies reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return moviesSections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviesSectionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesSectionsCell"];
    cell.sectionTitleLabel.text = moviesSections[indexPath.row];
    cell.sectionType = indexPath.row + 1;
    
    return cell;
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
