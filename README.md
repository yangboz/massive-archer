massive-archer
==============

Coding test for GoGO Tech Limited!

## GoGo Coding testing here:

### Live:http://pastebin.com/QtYNB2Av

### Raw:

GoGo Tech Limited - iOS / Android app developer
 
Please choose your platform of choice to implement the following (iOS - Objective-C. Android - Java or Scala). Major bonus points if you do both.
 
(These points may be updated from time to time, but the main criteria should remain stable. Please check this page for up-to-date hints / information. Feel free to send any questions to gogovanapp@gmail.com)
 
1. This Web page displays the marine traffic around the world: https://www.marinetraffic.com/en/
 
2. By extracting the data feed, write a mobile application that displays a map view with vessel icons. You do not require an API key for this. This item implies that you should reverse-engineer the Web page version to figure out how to obtain the vessel information without having the use an API key, as in the Web version. (Hint: Use Firebug or Chrome Developer Tools. If you send the exact same HTTP request as the Web browser you'll be able to get the data. With the right tricks / info you should be able to obtain the data even using curl.) This app is not intended to be used in production so stability of the "data feed" is not very important -- as long as it works for demonstration purposes for a couple of minutes it will be considered having satisfied this requirements fully.
 
If you fail to extract the feed, you can use this snapshot: http://pastebin.com/8vELHLAE. Document the methods that you have tried to extract the feed in your submission.
 
3. The app should center on Hong Kong by default (sw_x: 112, sw_y: 21, ne_x: 117, ne_y: 24, zoom: 9). The user should be able to pan / zoom the map view and vessel icons should be populated following the focus of the map. (Bonus points: Update the positions in real time. Real time is defined as a shorter than 5 minute update interval.)
 
4. Provide a search function to search vessel by Vessel Number / Port (i.e. the search function in the Web version).
 
5. Submit the _complete source package_ to gogovanapp@gmail.com. You can post a link if your file is bigger than 10MB. If you use any third party libraries / nonstandard build tools, document the build instructions clearly in a readme file. If we struggle too much to build your application from source your entry may be discarded.
 
6. Submissions will be evaluated on the following criteria:
 
- Coding style: 40% Ease of maintenance; terseness; use of best practices; leverage latest technologies / libraries / clever coding techniques; etc. Verbose code comments are not required. Good code should be self documenting. Good comments are short and to the point. Appropriate choice of 3rd party libraries is encouraged. Reinventing the square wheel where popular libraries exist will likely lead to mark deduction.
 
- Performance: 30% UI smoothness; scalability
 
- Compatibility: 20% Does the app adapt gracefully to different device configurations / orientations / screen sizes?
 
- UI aesthetics: 10%
