//
//  ViewController.m
//  base
//
//  Created by Daniel Eisner on 2/12/2014.
//  Copyright (c) 2014 Bionym. All rights reserved.
//

#import "ViewController.h"

NSString* provisionIdToString(NclProvisionId provisionId){
	NSMutableString* result=[[NSMutableString alloc] init];
	for(unsigned i=0; i<NCL_PROVISION_ID_SIZE; ++i)
		[result appendFormat: @"%x ", provisionId[i]];
	return result;
}

const char* disconnectionReasonToString(NclDisconnectionReason reason){
	switch(reason){
		case NCL_DISCONNECTION_LOCAL:
			return "NCL_DISCONNECTION_LOCAL";
		case NCL_DISCONNECTION_TIMEOUT:
			return "NCL_DISCONNECTION_TIMEOUT";
		case NCL_DISCONNECTION_FAILURE:
			return "NCL_DISCONNECTION_FAILURE";
		case NCL_DISCONNECTION_REMOTE:
			return "NCL_DISCONNECTION_REMOTE";
		case NCL_DISCONNECTION_CONNECTION_TIMEOUT:
			return "NCL_DISCONNECTION_CONNECTION_TIMEOUT";
		case NCL_DISCONNECTION_LL_RESPONSE_TIMEOUT:
			return "NCL_DISCONNECTION_LL_RESPONSE_TIMEOUT";
		case NCL_DISCONNECTION_OTHER:
			return "NCL_DISCONNECTION_OTHER";
		default: break;
	}
	return "invalid disconnection reason, something bad happened";
}

void callback(NclEvent event, void* userData){
	ViewController* v=(__bridge ViewController*)userData;
	switch(event.type){
		case NCL_EVENT_ERROR:
			[v.messageLog add: [NSString stringWithFormat: @"NCL_EVENT_ERROR"]];
			break;
		case NCL_EVENT_INIT:
			[v.messageLog add: [NSString stringWithFormat: @"NCL_EVENT_INIT %s", event.init.success?"success":"failure"]];
			break;
		case NCL_EVENT_DISCOVERY:{
			//turn identifier into string
			NSString* cellString=[NSString stringWithFormat: @"RSSI: %d", event.discovery.rssi];
			//update unprovisioned Nymis table
			if(event.discovery.nymiHandle>=[v->unprovisionedNymiCells count]){
				UITableViewCell* cell=[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"unprovisionedNymis"];
				cell.textLabel.text=cellString;
				[v->unprovisionedNymiCells addObject: cell];
				dispatch_async(dispatch_get_main_queue(), ^{ [v.unprovisionedNymisTable reloadData]; });
			}
			else{
				dispatch_async(
					dispatch_get_main_queue(),
					^{
						UITableViewCell* cell=[v->unprovisionedNymiCells objectAtIndex: event.discovery.nymiHandle];
						cell.textLabel.text=cellString;
					}
				);
			}
			//message
			[v.messageLog add: [NSString stringWithFormat: @"NCL_EVENT_DISCOVERY Nymi handle: %d, RSSI: %d", event.discovery.nymiHandle, event.discovery.rssi]];
			break;
		}
		case NCL_EVENT_FIND:{
			//turn provision ID into string
			NSString* provisionString=provisionIdToString(event.find.provisionId);
			NSString* cellString=[NSString stringWithFormat: @"RSSI: %d, id: %@", event.find.rssi, provisionString];
			//update provisioned Nymis table
			if(event.find.nymiHandle>=[v->provisionedNymiCells count]){
				UITableViewCell* cell=[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"provisionedNymis"];
				cell.textLabel.text=cellString;
				[v->provisionedNymiCells addObject: cell];
				dispatch_async(dispatch_get_main_queue(), ^{ [v.provisionedNymisTable reloadData]; });
			}
			else{
				dispatch_async(
					dispatch_get_main_queue(),
					^{
						UITableViewCell* cell=[v->provisionedNymiCells objectAtIndex: event.find.nymiHandle];
						cell.textLabel.text=cellString;
					}
				);
			}
			//message
			[v.messageLog add: [NSString stringWithFormat: @"NCL_EVENT_FIND Nymi handle: %d, RSSI: %d, provision id: %@", event.find.nymiHandle, event.find.rssi, provisionString]];
			break;
		}
		case NCL_EVENT_AGREEMENT:
			//message
			[v.messageLog add: [NSString stringWithFormat:
				@"NCL_EVENT_AGREE Nymi handle: %d LEDs: %d%d%d%d%d %d%d%d%d%d",
				event.agreement.nymiHandle,
				event.agreement.leds[0][0],
				event.agreement.leds[0][1],
				event.agreement.leds[0][2],
				event.agreement.leds[0][3],
				event.agreement.leds[0][4],
				event.agreement.leds[1][0],
				event.agreement.leds[1][1],
				event.agreement.leds[1][2],
				event.agreement.leds[1][3],
				event.agreement.leds[1][4]
			]];
			break;
		case NCL_EVENT_PROVISION:{
			//remember the provision
			v->provisions.push_back(event.provision.provision);
			//update provision table
			UITableViewCell* cell=[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"provisions"];
			cell.textLabel.text=provisionIdToString(event.provision.provision.id);
			[v->provisionCells addObject: cell];
			dispatch_async(dispatch_get_main_queue(), ^{ [v.provisionsTable reloadData]; });
			//message
			[v.messageLog add: [NSString stringWithFormat:
				@"NCL_EVENT_PROVISION Nymi handle: %d provision ID: %@",
				event.provision.nymiHandle,
				provisionIdToString(event.provision.provision.id)
			]];
			break;
		}
		case NCL_EVENT_VALIDATION:
			[v.messageLog add: [NSString stringWithFormat:
				@"NCL_EVENT_VALIDATION Nymi handle: %d",
				event.validation.nymiHandle
			]];
			break;
		case NCL_EVENT_DISCONNECTION:
			[v.messageLog add: [NSString stringWithFormat:
				@"NCL_EVENT_DISCONNECTION Nymi handle: %d reason: %s",
				event.disconnection.nymiHandle,
				disconnectionReasonToString(event.disconnection.reason)
			]];
			break;
		case NCL_EVENT_ECG:
			[v.messageLog add: [NSString stringWithFormat:
				@"NCL_EVENT_ECG Nymi handle: %d samples: %d %d %d %d %d %d %d %d",
				event.ecg.nymiHandle,
				event.ecg.samples[0],
				event.ecg.samples[1],
				event.ecg.samples[2],
				event.ecg.samples[3],
				event.ecg.samples[4],
				event.ecg.samples[5],
				event.ecg.samples[6],
				event.ecg.samples[7]
			]];
			break;
		case NCL_EVENT_RSSI:
			[v.messageLog add: [NSString stringWithFormat:
				@"NCL_EVENT_RSSI Nymi handle: %d RSSI: %d",
				event.rssi.nymiHandle,
				event.rssi.rssi
			]];
			break;
		default: break;
	}
}

@interface ViewController ()

@end

@implementation ViewController

//-----UIViewController-----//
- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	//error steam
	errorStream=fopen([[NSHomeDirectory() stringByAppendingString: @"/Documents/errorStream.txt"] UTF8String], "w+");
	errorStreamPosition=0;
	error=[[NSMutableString alloc] init];
	errorTimer=[NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(pumpErrorStream:) userInfo: nil repeats: YES];
	//tables
	unprovisionedNymiCells=[[NSMutableArray alloc] init];
	selectedUnprovisionedNymi=-1;
	provisionCells=[[NSMutableArray alloc] init];
	selectedProvision=-1;
	provisionedNymiCells=[[NSMutableArray alloc] init];
	selectedProvisionedNymi=-1;
	//NCL
	nclSetIpAndPort("localhost", 9089);
	NclBool result=nclInit(
		callback,
		(__bridge void*)self,
		"iOS Base",
		NCL_MODE_DEFAULT,
		errorStream
	);
	[self.messageLog add: [NSString stringWithFormat: @"called nclInit, returned %s", result?"success":"failure"]];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)dealloc{
	nclFinish();
	[errorTimer invalidate];
	fclose(errorStream);
}

//-----UITableViewDataSource-----//
- (UITableViewCell*)tableView: (UITableView*)tableView cellForRowAtIndexPath: (NSIndexPath*)indexPath{
	if(tableView==self.unprovisionedNymisTable)
		return [unprovisionedNymiCells objectAtIndex: indexPath.row];
	else if(tableView==self.provisionsTable)
		return [provisionCells objectAtIndex: indexPath.row];
	else if(tableView==self.provisionedNymisTable)
		return [provisionedNymiCells objectAtIndex: indexPath.row];
	return nil;
}

-(NSInteger)tableView: (UITableView*)tableView numberOfRowsInSection: (NSInteger)section{
	if(tableView==self.unprovisionedNymisTable)
		return [unprovisionedNymiCells count];
	else if(tableView==self.provisionsTable)
		return [provisionCells count];
	else if(tableView==self.provisionedNymisTable)
		return [provisionedNymiCells count];
	return 0;
}

//-----UITableViewDelegate-----//
-(void)tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath{
	if(tableView==self.unprovisionedNymisTable)
		selectedUnprovisionedNymi=(int)indexPath.row;
	else if(tableView==self.provisionsTable)
		selectedProvision=(int)indexPath.row;
	else if(tableView==self.provisionedNymisTable)
		selectedProvisionedNymi=(int)indexPath.row;
}

//-----IBActions-----//
- (IBAction)discoverUnprovisioned: (id)sender{
	NclBool result=nclStartDiscovery();
	[self.messageLog add: [NSString stringWithFormat: @"called nclStartDiscovery, returned %s", result?"success":"failure"]];
}

- (IBAction)agree: (id)sender{
	if(selectedUnprovisionedNymi<0){
		[self.messageLog add: @"select an unprovisioned Nymi to agree"];
		return;
	}
	NclBool result=nclAgree(selectedUnprovisionedNymi);
	[self.messageLog add: [NSString stringWithFormat:
		@"called nclAgree with Nymi handle %d, returned %s",
		selectedUnprovisionedNymi,
		result?"success":"failure"
	]];
}

- (IBAction)provision: (id)sender{
	if(selectedUnprovisionedNymi<0){
		[self.messageLog add: @"select an unprovisioned Nymi to provision"];
		return;
	}
	NclBool result=nclProvision(selectedUnprovisionedNymi);
	[self.messageLog add: [NSString stringWithFormat: @"called nclProvision with Nymi handle %d, returned %s",
		selectedUnprovisionedNymi,
		result?"success":"failure"
	]];
}

- (IBAction)findProvisioned: (id)sender{
	if(selectedProvision<0){
		[self.messageLog add: @"select a provision to use in discovery"];
		return;
	}
	NclBool result=nclStartFinding(&provisions[selectedProvision], 1, NCL_FALSE);
	[self.messageLog add: [NSString stringWithFormat: @"called nclStartFind with provision with ID %@, returned %s",
		provisionIdToString(provisions[selectedProvision].id),
		result?"success":"failure"
	]];
}

- (IBAction)revoke: (id)sender{
	if(selectedProvision<0){
		[self.messageLog add: @"select a provision to revoke"];
		return;
	}
	NclProvision provision=provisions[selectedProvision];
	provisions.erase(provisions.begin()+selectedProvision);
	[provisionCells removeObjectAtIndex: selectedProvision];
	dispatch_async(dispatch_get_main_queue(), ^{ [self.provisionsTable reloadData]; });
	selectedProvision=-1;
	[self.messageLog add: [NSString stringWithFormat: @"revoked provision with ID %@", provisionIdToString(provision.id)]];
}

- (IBAction)validate: (id)sender{
	if(selectedProvisionedNymi<0){
		[self.messageLog add: @"select a provisioned Nymi to validate"];
		return;
	}
	NclBool result=nclValidate(selectedProvisionedNymi);
	[self.messageLog add: [NSString stringWithFormat: @"called nclValidate with Nymi handle %d, returned %s",
		selectedProvisionedNymi,
		result?"success":"failure"
	]];
}

- (IBAction)startEcg: (id)sender{
	if(selectedProvisionedNymi<0){
		[self.messageLog add: @"select a provisioned Nymi to start ECG"];
		return;
	}
	NclBool result=nclStartEcgStream(selectedProvisionedNymi);
	[self.messageLog add: [NSString stringWithFormat: @"called nclStartEcgStream with Nymi handle %d, returned %s",
		selectedProvisionedNymi,
		result?"success":"failure"
	]];
}

- (IBAction)stopEcg: (id)sender{
	if(selectedProvisionedNymi<0){
		[self.messageLog add: @"select a provisioned Nymi to stop ECG"];
		return;
	}
	NclBool result=nclStopEcgStream(selectedProvisionedNymi);
	[self.messageLog add: [NSString stringWithFormat: @"called nclStopEcgStream with Nymi handle %d, returned %s",
		selectedProvisionedNymi,
		result?"success":"failure"
	]];
}

- (IBAction)rssi: (id)sender{
	if(selectedProvisionedNymi<0){
		[self.messageLog add: @"select a provisioned Nymi to get RSSI"];
		return;
	}
	NclBool result=nclGetRssi(selectedProvisionedNymi);
	[self.messageLog add: [NSString stringWithFormat: @"called nclGetRssi with Nymi handle %d, returned %s",
		selectedProvisionedNymi,
		result?"success":"failure"
	]];
}

- (IBAction)disconnect: (id)sender{
	if(selectedProvisionedNymi<0){
		[self.messageLog add: @"select a provisioned Nymi to disconnect"];
		return;
	}
	NclBool result=nclDisconnect(selectedProvisionedNymi);
	[self.messageLog add: [NSString stringWithFormat: @"called nclDisconnect with Nymi handle %d, returned %s",
		selectedProvisionedNymi,
		result?"success":"failure"
	]];
}

//------error timer callback-----//
- (void)pumpErrorStream: (NSTimer*)timer{
	nclLockErrorStream();
	fpos_t newErrorStreamPosition;
	fgetpos(errorStream, &newErrorStreamPosition);
	while(errorStreamPosition<newErrorStreamPosition){
		fsetpos(errorStream, &errorStreamPosition);
		char c=fgetc(errorStream);
		if(c=='\n'){
			[self.messageLog add: error];
			[error deleteCharactersInRange: NSMakeRange(0, [error length])];
		}
		else [error appendFormat: @"%c", c];
		++errorStreamPosition;
	}
	nclUnlockErrorStream();
}

@end
