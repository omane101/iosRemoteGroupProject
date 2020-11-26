Unit 8: Group Milestone - README Example
===

# Real Time Foot Traffic Application

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
RTFT is a Yelp like application that can allow users to view recent reviews of businesses and provide real time updates as to the current foot traffic at that business using crowd-sourced

### App Evaluation
- **Category:** Social Networking / Food
- **Mobile:** This app would be primarily developed for mobile.
- **Story:** Users will see a list of Restaurants within a certain radius with foot traffic levels. Users can also vote on the level if they are currently at that location.
- **Market:** Individuals looking for places that may have lower waiting times or that are less busy and thus less of a virus-risk.
- **Habit:** This app could be used as often as the user goes out to eat. 
- **Scope:** First the app would be limited to the list of restaurants provided. On a larger scope it would branch beyone restuarants to other businesses like bars, lounges etc.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

*Be able to go to a profile page and customize it
*Be able to generate a list of places within a radius of location 
*Be able to vote either: too busy, not busy, or any other button ideas
*Ability to quickly give 1-5 stars for business
*View the current foot traffic level/check-in feature to count
*Ability to offer more in depth review


**Optional Nice-to-have Stories**

*Have special reviews for covid related matter
*Chat ability 


### 2. Screen Archetypes

* Login 
* Register - User signs up or logs into their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their profile information to be properly matched with another person. 
* List of Places Screen
  *...
* Detailed view of Places Screen
  *...
* Profile Screen 
   * Allows user to upload a photo and fill in information that is interesting to them and others

* Settings Screen
   * Lets people change language, and app notification settings.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* List of Places
* Profile

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available


## Wireframes
<img src="https://i.imgur.com/IdvEUEI.png" width=800><br>

# Networking
### 1.	Login Page

## Authentication with google account:

https://firebase.google.com/docs/auth/ios/google-signin#swift_5
  
## Authentication with Facebook account:

https://firebase.google.com/docs/auth/ios/facebook-login

## Authentication with Apple account:

https://firebase.google.com/docs/auth/ios/apple


## 2. Profile Page:
https://firebase.google.com/docs/auth/ios/manage-users
Yelp API – GET Request For Searching 
Required Parameters for the API
Name	Type	Description
term	String	Used to search for food or restaurants
Latitude	Decimal	Self-explanatory
Longitude	Decimal	Self-explanatory
Radius	Int	Self-explanatory
Open_now	Boolean	Self-explanatory
Any other filters you would like to add? https://www.yelp.com/developers/documentation/v3/business_search
		

Response – Highlighted are important
Name	Type	Description
total	int	Total number of business Yelp finds based on the search criteria. Sometimes, the value may exceed 1000. In such case, you still can only get up to 1000 businesses using multiple queries and combinations of the "limit" and "offset" parameters.
businesses	object[]	List of business Yelp finds based on the search criteria.
businesses[x].categories	object[]	List of category title and alias pairs associated with this business.
businesses[x].categories[x].alias	string	Alias of a category, when searching for business in certain categories, use alias rather than the title.
businesses[x].categories[x].title	string	Title of a category for display purpose.
businesses[x].coordinates	object	Coordinates of this business.
businesses[x].coordinates.latitude	decimal	Latitude of this business.
businesses[x].coordinates.longitude	decimal	Longitude of this business.
businesses[x].display_phone	string	Phone number of the business formatted nicely to be displayed to users. The format is the standard phone number format for the business's country.
businesses[x].distance	decimal	Distance in meters from the search location. This returns meters regardless of the locale.
businesses[x].id	string	Unique Yelp ID of this business. Example: '4kMBvIEWPxWkWKFN__8SxQ'
businesses[x].alias	string	Unique Yelp alias of this business. Can contain unicode characters. Example: 'yelp-san-francisco'. Also see What's the difference between the Yelp business ID and business alias?

businesses[x].image_url	string	URL of photo for this business.
businesses[x].is_closed	bool	Whether business has been (permanently) closed
businesses[x].location	object	Location of this business, including address, city, state, zip code and country.
businesses[x].location.address1	string	Street address of this business.
businesses[x].location.address2	string	Street address of this business, continued.
businesses[x].location.address3	string	Street address of this business, continued.
businesses[x].location.city	string	City of this business.
businesses[x].location.country	string	ISO 3166-1 alpha-2 country code of this business.
businesses[x].location.display_address	string[]	Array of strings that if organized vertically give an address that is in the standard address format for the business's country.
businesses[x].location.state	string	ISO 3166-2 (with a few exceptions) state code of this business.
businesses[x].location.zip_code	string	Zip code of this business.

businesses[x].name	string	Name of this business.
businesses[x].phone	string	Phone number of the business.
businesses[x].price	string	Price level of the business. Value is one of $, $$, $$$ and $$$$.
businesses[x].rating	decimal	Rating for this business (value ranges from 1, 1.5, ... 4.5, 5).
businesses[x].review_count	int	Number of reviews for this business.
businesses[x].url	string	URL for business page on Yelp.
businesses[x].transactions	string[]	List of Yelp transactions that the business is registered for. Current supported values are pickup, delivery and restaurant_reservation.
region	dict	Suggested area in a map to display results in.
region.center	dict	Center position of map area.
region.center.latitude	decimal	Latitude position of map bounds center.
region.center.longitude	decimal	Longitude position of map bounds center.

Yelp GET Request For Specific Individual Business
GET https://api.yelp.com/v3/businesses/{id}
The same response values will be used above.



## DEMO
<img src="https://i.imgur.com/peQAljA.gif" width=200><br>

