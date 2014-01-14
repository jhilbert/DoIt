//
//  ViewController.m
//  DoIt
//
//  Created by Josef Hilbert on 13.01.14.
//  Copyright (c) 2014 Josef Hilbert. All rights reserved.
//

#import "ViewController.h"
#import "ToDoItem.h"

@interface ViewController ()

{
    
    __weak IBOutlet UIButton *myEditButton;
    __weak IBOutlet UITextField *myTextField;
    __weak IBOutlet UITableView *myTableView;
    NSMutableArray *items;
    NSArray *colors;
    BOOL isEditModeEnabled;
    NSIndexPath *deleteAtIndexPath;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    items = [NSMutableArray arrayWithObjects:[[ToDoItem alloc] initWithString:@"One"], [[ToDoItem alloc] initWithString:@"Two"], [[ToDoItem alloc] initWithString:@"Three"], nil];
    
    isEditModeEnabled = NO;
    [myTableView setEditing:YES animated:NO];
    
}
- (IBAction)onAddButtonPressed:(UIButton*)addButton {
    
    if ([myTextField.text isEqualToString:@""])
    {
        //
    }
    else
    {
        [items addObject:[[ToDoItem alloc] initWithString:myTextField.text]];
        [myTableView reloadData];
        myTextField.text = @"";
        [myTextField resignFirstResponder];
    }
    
}

- (IBAction)onEditButtonPressed:(UIButton*)editButton {
    if (isEditModeEnabled == NO)
    {
        isEditModeEnabled = YES;
        [myEditButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        isEditModeEnabled = NO;
        [myEditButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    [myTableView reloadData];
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"canMove");
    if (isEditModeEnabled == YES)
        return YES;
    else
        return NO;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    ToDoItem *item = [items objectAtIndex:sourceIndexPath.row];
    [items removeObjectAtIndex:sourceIndexPath.row];
    [items insertObject:item atIndex:destinationIndexPath.row];
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSLog(@"target Index Path For Move From Row at index");
    return proposedDestinationIndexPath;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    ToDoItem *item = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.text;
    cell.textLabel.textColor = item.color;
    return cell;
    
}
- (IBAction)setColorOnSwipe:(UISwipeGestureRecognizer*)swipe{
    
    
    colors = @[[UIColor blackColor], [UIColor redColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blackColor]];
    
    CGPoint swipeLocation = [swipe locationInView:myTableView];
    NSIndexPath *swipedIndexPath = [myTableView indexPathForRowAtPoint:swipeLocation];
   
    ToDoItem *tti = [items objectAtIndex:swipedIndexPath.row];
    
    for (int i=0; i < colors.count; i++)
    {
        if (colors[i] == tti.color)
        {
            tti.color = colors[i+1];
            i=colors.count;
        }
    }
    [myTableView reloadData];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isEditModeEnabled)
    {
        
        [items removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
    }
    else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor greenColor];
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isEditModeEnabled)
        
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;

}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        deleteAtIndexPath = indexPath;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Confirm Delete" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
        
        [alert show];
        
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Delete"])
    {
        
        [items removeObjectAtIndex:deleteAtIndexPath.row];
        
    }
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
