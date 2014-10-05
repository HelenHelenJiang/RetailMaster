simplify-nymi-example-ios
=====================

Example iOS project with [Nymi](http://dev.getnymi.com/) and [Simplify](https://www.simplify.com/commerce/docs) frameworks.


## Requirements
* Download [Nymi SDK & Emulator](http://developers.getnymi.com/sdk/index.html)
* Please register a developer account with [Simplify Commerce](https://www.simplify.com/commerce/login/signup) for API Keys
* If you are developing mobile applications, please run a server instance for running payment transactions where you have your public & private keys persisted.
    You can clone this [repo](https://github.com/simplifycom/simplify_payment_examples) and update the public & private keys in charge.php


## Steps

1. Open project using Xcode

2. Update API Keys (line 114) & Server URL (line 148) values in [ViewController.m] (https://github.com/simplifycom/simplify-nymi-example-ios/blob/master/Classes/ViewController.m)

3. Update local IP for emulator (line 12) with whatever your local IP is.

4. Start the Nymulator - Add a New Device and activate it.

5. Run the Project 

6. Tap Start to connect to the Nymulator

7. Tap Pay to initiate a Simplify Payment

