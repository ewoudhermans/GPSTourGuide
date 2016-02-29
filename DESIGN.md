#TourGuide - Design document

Ewoud Hermans

When you are in a certain radius of a sight the TourGuide app, using your GPS location, gives you a notification about that sight.

When the app is opened the user sees the sign in interface. Here you can sign in with your username and password. When you do not already have an account, you can click the sign up button to create one.

The sign up interface asks for a first name, last name, username, email, password and repeated password. When the user has filled in al the fields he can tab the sign up button and is then asked if he wants to sign in. There is also a button to go back to the sign in interface, but then no account is created.

Once signed in, the user sees the MapView interface. The whole screen is filled with a map centered on the users GPS location. In the top op the screen is a menu bar with four buttons. The most left button is the “sign out” button. The second left button is the “add sight” button. This button directs the user to the interface where he can add information about a sight on his current location. The second right button is the “closest sights” button. When tabbed this button directs the user to a table view. This table view shows the ten closest sights. The user can tab a row to read about the tabbed sight. The rightest button centers the map on the user’s location. 

The map shows pins on locations where a user has added some information. When the user tabs on a pin he is directed to the notification interface where the user can read about the sight.

The user also has the possibility to add information about a sight where he is not currently located. To do this the user has to tab and hold the location where he wants to add something. He is then prompted with the question whether or not he wants to add something on that location. If the the user tabs yes, he is directed to the add sight interface.

The add sight interface has two text fields. One for the title of the sight and one for the information about the sight. The user has to fill them in. The user can also add an image file. When the user is ready he can tab the submit button and all the information is added to a database.

Features

These are the features that form the Minimum viable product (MVP):

•	User get notification when near a sights location (in database).
•	User can view nearby sights on a map.
•	User can tab the notification to read about the sight.
•	User can add a sight on location to the database.
