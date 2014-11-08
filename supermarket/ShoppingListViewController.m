//
//  ShoppingListViewController.m
//  supermarket
//
//  Created by Emiliano Bivachi on 06/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "ShoppingListViewController.h"
#import "ShopItemCollectionViewCell.h"
#import "ScanViewController.h"
#import "DismissModalProtocol.h"

@interface ShoppingListViewController () <DismissModalProtocol, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shopList;
@end

@implementation ShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.shopList = [[NSMutableArray alloc] init];
    for (int i=0; i<50; i++) {
        [self.shopList addObject:[NSString stringWithFormat:@"Cell %d", i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DismissModalProtocol

- (void)backFromViewController:(UIViewController *)vc {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)backFromViewController:(UIViewController *)vc withObject:(id)obj {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"BarScanSegue"]) {
        ScanViewController *vc = (ScanViewController *)segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.shopList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ShopItemIdentifier";
    ShopItemCollectionViewCell *cell = (ShopItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *shopItem = [self.shopList objectAtIndex:indexPath.row];
    [cell.titleLabel setText:shopItem];
    return cell;
}

@end
