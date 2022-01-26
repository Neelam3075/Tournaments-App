# Tournament App - Neelam Soni

App to demonstrate Flutter Development Skills

## Overview

This project contains overall 2 functional Screen, Login and Dashboard which also has support for localization for English and Japanese.
Project is Bloc state Management

### Project Brief:

**1. Login screen:**

  This will be the first screen.
  a. It will have 4 UI items:

    i. An image of game.tv logo
    ii. Username text field: It should have validation of min 3 characters and max 11 with proper error message if the validation fails.
    iii. Password field: It should have validation of min 3 characters and max 11 with proper error message if the validation fails.
    iv. Submit button: It should be disabled if either validation fails.
    v. Additional feature on this screen is to change language

  b. Other points:

    i. If a user has already logged in, they should be automatically logged in and sent to the home screen directly next time they open the app.
    ii. Below user credential is Hardcoded in the app, and validation messages will be display accordingly.
      User 1: 9898989898 / password123
      User 2: 9876543210 / password123
    iii. Some UI points:
      1. All ui components are horizontally and vertically centered both, one below the other

**2. Dashboard screen:**
This will hold some information related to the logged in user, and will load Tournament list .

This screen contains 2 parts,
    1. Profile of user at top
    2. List of tournament loaded from given api
    3. It's a complete scrollable page
    4. List has infinite Scroll for the api with pagination

### Additional(Bonus) Features included:
1. Add support for localization in the app for English and Japanese.
2. Build an API on https://restdb.io/ for the User Details section.
3. Bloc State Management
