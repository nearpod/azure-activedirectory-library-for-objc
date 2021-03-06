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

import UIKit
import ADAL

class ViewController: UIViewController
{
    @IBOutlet weak var statusTextField: UITextView?

    func updateStatusField(_ text: String)
    {
        DispatchQueue.main.async {
            self.statusTextField?.text = text;
        }
    }
    
    @IBAction func acquireToken(_ sender:UIButton) {
        let authContext = ADAuthenticationContext(authority: "https://login.microsoftonline.com/common",
                                                  error: nil)
        
        authContext!.acquireToken(withResource: "https://graph.windows.net",
                                             clientId: "b92e0ba5-f86e-4411-8e18-6b5f928d968a",
                                             redirectUri: URL(string: "urn:ietf:wg:oauth:2.0:oob"))
        {
            (result) in
            
            if (result!.status != AD_SUCCEEDED)
            {
                if result!.error.domain == ADAuthenticationErrorDomain
                    && result!.error.code == ADErrorCode.ERROR_UNEXPECTED.rawValue {
                    
                    self.updateStatusField("Unexpected internal error occured");
                    
                } else {
                    
                    self.updateStatusField(result!.error.description)
                }
                
                return;
            }
            
            var expiresOnString = "(nil)"
            
            if let expiresOn = result!.tokenCacheItem.expiresOn {
                expiresOnString = String(describing: expiresOn)
            }
            
            let status = String(format: "Access token: %@\nexpiration:%@", result!.accessToken, expiresOnString)
            self.updateStatusField(status)
        }
    }
}
