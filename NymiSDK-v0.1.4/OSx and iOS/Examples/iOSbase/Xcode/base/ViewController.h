//
//  ViewController.h
//  base
//
//  Created by Daniel Eisner on 2/12/2014.
//  Copyright (c) 2014 Bionym. All rights reserved.
//

#import "messageLog.h"

#include "ncl.h"

#import <UIKit/UIKit.h>

#include <cstdio>
#include <vector>

@interface ViewController: UIViewController <UITableViewDataSource, UITableViewDelegate>{
	@public
		FILE* errorStream;
		fpos_t errorStreamPosition;
		NSMutableString* error;
		NSTimer* errorTimer;
		NSMutableArray* unprovisionedNymiCells;
		int selectedUnprovisionedNymi;
		NSMutableArray* provisionCells;
		int selectedProvision;
		NSMutableArray* provisionedNymiCells;
		int selectedProvisionedNymi;
		std::vector<NclProvision> provisions;
}

@property IBOutlet MessageLog* messageLog;
@property IBOutlet UITableView* unprovisionedNymisTable;
@property IBOutlet UITableView* provisionsTable;
@property IBOutlet UITableView* provisionedNymisTable;

@end
