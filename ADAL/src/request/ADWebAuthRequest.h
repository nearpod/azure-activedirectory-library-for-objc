// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ADWebRequest.h"

@interface ADWebAuthRequest : ADWebRequest
{
    NSDate* _startTime;
    BOOL _retryIfServerError;
    BOOL _returnRawResponse;
    BOOL _acceptOnlyOKResponse;
    
    NSMutableDictionary* _responseDictionary;
    
    // A dictionary of key/value pairs that is either included as the query parameters on a GET
    // request or serialized into JSON for a POST request
    NSDictionary<NSString*,NSString*> * _requestDictionary;
}

@property BOOL returnRawResponse;
@property BOOL retryIfServerError;
@property BOOL acceptOnlyOKResponse;

@property (readonly) NSDate* startTime;
@property (copy) NSDictionary<NSString *, NSString *> * requestDictionary;

- (void)sendRequest:(ADWebResponseCallback)completionBlock;

@end
