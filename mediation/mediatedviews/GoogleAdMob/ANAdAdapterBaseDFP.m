/*   Copyright 2015 APPNEXUS INC
 
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

#import "ANAdAdapterBaseDFP.h"



@implementation ANAdAdapterBaseDFP

+ (GADRequest *)googleAdRequestFromTargetingParameters:(ANTargetingParameters *)targetingParameters {
    GADRequest *request = [GADRequest request];
    return  [[self class] completeAdRequest:request fromTargetingParameters:targetingParameters];
}

+ (DFPRequest *)dfpRequestFromTargetingParameters:(ANTargetingParameters *)targetingParameters
{
    DFPRequest  *dfpRequest  = [DFPRequest request];
    return  (DFPRequest *)[[self class] completeAdRequest:dfpRequest fromTargetingParameters:targetingParameters];
}

+ (GADRequest *)completeAdRequest: (GADRequest *)gadRequest
          fromTargetingParameters: (ANTargetingParameters *)targetingParameters
{

    NSString *content_url = targetingParameters.customKeywords[@"content_url"];
    if ([content_url length] > 0)
    {
        gadRequest.contentURL = content_url;

        NSMutableDictionary *dictWithoutContentUrl = [targetingParameters.customKeywords mutableCopy];
        [dictWithoutContentUrl removeObjectForKey:@"content_url"];
        targetingParameters.customKeywords = dictWithoutContentUrl;
    }

    ANLocation *location = targetingParameters.location;
    if (location) {
        [gadRequest setLocationWithLatitude:location.latitude
                               longitude:location.longitude
                                accuracy:location.horizontalAccuracy];
    }

    GADExtras *extras = [[GADExtras alloc] init];
    NSMutableDictionary *extrasDictionary = [targetingParameters.customKeywords mutableCopy];
    if (!extrasDictionary) {
        extrasDictionary = [[NSMutableDictionary alloc] init];
    }
    NSString *age = targetingParameters.age;
    if (age) {
        [extrasDictionary setValue:age forKey:@"Age"];
    }
    extras.additionalParameters = extrasDictionary;
    [gadRequest registerAdNetworkExtras:extras];

    return gadRequest;
}


+ (ANAdResponseCode *)responseCodeFromRequestError:(GADRequestError *)error {
    ANAdResponseCode *code = ANAdResponseCode.INTERNAL_ERROR;
    
    switch (error.code) {
        case kGADErrorInvalidRequest:
            code = ANAdResponseCode.INVALID_REQUEST;
            break;
        case kGADErrorNoFill:
            code = ANAdResponseCode.UNABLE_TO_FILL;
            break;
        case kGADErrorNetworkError:
            code = ANAdResponseCode.NETWORK_ERROR;
            break;
        case kGADErrorServerError:
            code = ANAdResponseCode.NETWORK_ERROR;
            break;
        case kGADErrorOSVersionTooLow:
            code = ANAdResponseCode.INTERNAL_ERROR;
            break;
        case kGADErrorTimeout:
            code = ANAdResponseCode.NETWORK_ERROR;
            break;
        case kGADErrorAdAlreadyUsed:
            code = ANAdResponseCode.INTERNAL_ERROR;
            break;
        case kGADErrorMediationDataError:
            code = ANAdResponseCode.INVALID_REQUEST;
            break;
        case kGADErrorMediationAdapterError:
            code = ANAdResponseCode.INTERNAL_ERROR;
            break;
        case kGADErrorMediationInvalidAdSize:
            code = ANAdResponseCode.INVALID_REQUEST;
            break;
        case kGADErrorInternalError:
            code = ANAdResponseCode.INTERNAL_ERROR;
            break;
        case kGADErrorInvalidArgument:
            code = ANAdResponseCode.INVALID_REQUEST;
            break;
        default:
            code = ANAdResponseCode.INTERNAL_ERROR;
            break;
    }
    return code;
}

@end
