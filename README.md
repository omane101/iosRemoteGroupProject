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

## 3. Feed Page:

/businesses/{id}
This endpoint returns detailed business content. Normally, you would get the Business ID from /businesses/search, /businesses/search/phone, /transactions/{transaction_type}/search or /autocomplete. To retrieve review excerpts for a business, please refer to our Reviews endpoint (/businesses/{id}/reviews)

Note: at this time, the API does not return businesses without any reviews.

Request
GET https://api.yelp.com/v3/businesses/{id}
Parameters
Name	Type	Description
locale	string	Optional. Specify the locale into which to localize the business information. See the list of supported locales. Defaults to en_US.
Response Body
{
  "id": "WavvLdfdP6g8aZTtbBQHTw",
  "alias": "gary-danko-san-francisco",
  "name": "Gary Danko",
  "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
  "is_claimed": true,
  "is_closed": false,
  "url": "https://www.yelp.com/biz/gary-danko-san-francisco?adjust_creative=wpr6gw4FnptTrk1CeT8POg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=wpr6gw4FnptTrk1CeT8POg",
  "phone": "+14157492060",
  "display_phone": "(415) 749-2060",
  "review_count": 5296,
  "categories": [
    {
      "alias": "newamerican",
      "title": "American (New)"
    },
    {
      "alias": "french",
      "title": "French"
    },
    {
      "alias": "wine_bars",
      "title": "Wine Bars"
    }
  ],
  "rating": 4.5,
  "location": {
    "address1": "800 N Point St",
    "address2": "",
    "address3": "",
    "city": "San Francisco",
    "zip_code": "94109",
    "country": "US",
    "state": "CA",
    "display_address": [
      "800 N Point St",
      "San Francisco, CA 94109"
    ],
    "cross_streets": ""
  },
  "coordinates": {
    "latitude": 37.80587,
    "longitude": -122.42058
  },
  "photos": [
    "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
    "https://s3-media4.fl.yelpcdn.com/bphoto/FmXn6cYO1Mm03UNO5cbOqw/o.jpg",
    "https://s3-media4.fl.yelpcdn.com/bphoto/HZVDyYaghwPl2kVbvHuHjA/o.jpg"
  ],
  "price": "$$$$",
  "hours": [
    {
      "open": [
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 0
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 1
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 2
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 3
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 4
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 5
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 6
        }
      ],
      "hours_type": "REGULAR",
      "is_open_now": false
    }
  ],
  "transactions": [],
  "special_hours": [
    {
      "date": "2019-02-07",
      "is_closed": null,
      "start": "1600",
      "end": "2000",
      "is_overnight": false
    }
  ]
  
  
