/*   Copyright 2014 APPNEXUS INC
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ANUniversalAdFetcher.h"
#import "ANMRAIDContainerView.h"
#import "ANStandardAd.h"

static NSString *const kANUniversalAdFetcherFireResponseURLRequestedNotification  = @"kANUniversalAdFetcherFireResponseURLRequestedNotification";
static NSString *const kANUniversalAdFetcherFireResponseURLRequestedReason        = @"kANUniversalAdFetcherFireResponseURLRequestedReason";

@interface ANUniversalAdFetcher (ANTest)

@property (nonatomic, readwrite, strong) ANMRAIDContainerView *adView;
@property (nonatomic, readwrite, strong)  id                adObjectHandler;
@property (nonatomic, readwrite, strong) NSTimer *autoRefreshTimer;


- (void)handleStandardAd:(ANStandardAd *)standardAd;

@end