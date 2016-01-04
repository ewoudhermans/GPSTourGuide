# GPSTourGuide


Solved problem for the user

This application is going to be a new kind of tour guide. Using GPS, based on your location the app gives you interesting facts about your surroundings. When you are in a interested mood you can turn on the app. When you are radius of 20 meters of a certain sight (like the Anne Frank house), you get a notification from the app. When you open the notification it gives you a short factual description of the sight.

One of the things that makes this app different from other tour guide apps is that people can write their own information about sights. It’s not going to give you a link to Wikipedia for example. So the more active users there are, the more sights will be described.

Also should the information be short and factual. It should give you a short an interesting description and not a long boring text that takes to much time to read.

Features

-	Takes your location into account (uses GPS)
-	Gives you notifications about sights corresponding to your location
-	User can add information to a database, and the information is linked to a GPS location
-	As user you can rate the information provided by other users (thumbs up/ down)
-	When information has to many bad ratings it is automatically removed
-	User can (or has) to make an account
-	Once logged in user does not have to keep logging in when app is closed

Databases

1.	Users – There will be a user’s database with corresponding passwords provided by the users.
2.	Information – There will be an information database provided by the users.
3.	Locations – There will be a database of GPS locations, these locations (also provided by the user) should correspond to pieces in the information database.
4.	Ratings – There will be a database of ratings (how many thumbs up/ down a certain piece of information has), also corresponding to pieces in the information database), this is also provided by the user.

Parts of the application

-	Account creation interface
-	Log in interface
-	Settings interface
-	Map, zoomed in so it displays the set radius with icons where the sights are
-	Notification interface (where you read the information and rate the information)
-	Interface where you create new descriptions about sights

API’s

-	GPS API (Google maps)

Problems

-	Big databases
-	Using a radius with GPS
-	Can users use the app offline 

Similar application

-	City walks – This application presents you several self-guided walks in over 470 cities around the world. This is more a guide than an app that gives you short descriptions about sight. And you can not add your own information. This app is usable offline. 
-	Tourpal – Gives you locations of surrounding sight, restaurants, bars, hotels based on your GPS location. But does not give you information.
