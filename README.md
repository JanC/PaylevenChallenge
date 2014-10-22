PaylevenChallenge
=================

```
git clone https://github.com/JanC/PaylevenChallenge.git
cd PaylevenChallenge/
pod install
open PaylevenTest.xcworkspace
```
###Authentication
The Oauth2 is **not** implemented at all. I just use the Box SDK to get the access token that is later used in the implemented network client. So all the UI you see during the authentication is from Box SDK. _My_ work starts when you see the list of files :)

###PLBoxAPIClient
Responsible for fetching the data from the API. 

###PLJSONParser
Responsible to parsing the network data into the Model objects

###PLFileManager
Abstraction between the app and the network layer. It used the PLBoxAPIClient to fetch the data. Here would be the place to do any persistance into e.g. Core Data.

###PLListArrayDataSource
Generally, I try to make view controllers as light as possible. 

###Style
Fonts and colors from Payleven ;) 

### Resources


[objc.io](http://www.objc.io/issue-1/) - Best blog ever