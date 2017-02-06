//
//  HistoryVC.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/2/6.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import "HistoryVC.h"

@interface HistoryVC (){
    NSMutableArray *array;
}

@end

@implementation HistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    array=[[NSMutableArray alloc]init];
    array=[self.sqlite GetHistoryAll];
    [self.tableView setContentInset:UIEdgeInsetsMake(20,self.tableView.contentInset.left,self.tableView.contentInset.bottom,self.tableView.contentInset.right)];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Count:%lu" ,(unsigned long)[array count]);
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier=@"cell";
    HistoryCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell==nil){
        cell=[[HistoryCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    History *history=[array objectAtIndex:indexPath.row];
    cell.type.text=[NSString stringWithFormat:@"%d",history.type];
    cell.start_time.text=history.start_time;
    cell.finish_time.text=history.finish_time;
    cell.relate_time.text=history.relate_time;
    return cell;
}


@end
