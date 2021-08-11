// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
import ballerina/http;
import ballerinax/microsoft.outlook.mail;

configurable string refreshUrl = ?;
configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

mail:Configuration configuration = {
    clientConfig: {
        refreshUrl: refreshUrl,
        refreshToken : refreshToken,
        clientId : clientId,
        clientSecret : clientSecret
    }
};

mail:Client outlookClient = check new(configuration);

public function main() returns error? {
    mail:MessageContent messageContent = {
        message: {
            subject: "Ballerina Test Email",
            importance: "Low",
            body: {
                "contentType": "HTML",
                "content": "This is sent by sendMessage operation <b>Test</b>!"
            },
            toRecipients: [
                {
                emailAddress: {
                    address: "<email address>",
                    name: "<name>"
                }
            }
            ]
        },
        saveToSentItems: true
    };
    http:Response response = check oneDriveClient->sendMessage(messageContent);       
}
