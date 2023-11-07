# CraftyBay

Welcome to the CraftyBay repository! CraftyBay is your go-to e-commerce app, designed to offer you a fantastic shopping experience. With a variety of features like product categorization, product reviews, and a seamless shopping cart, CraftyBay makes shopping a breeze.

![App Screenshots](path-to-your-screenshot.png)

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Screenshots](#screenshots)

## Features
- **Product Categories**: Browse and shop for products across various categories.

- **Product Details**: View detailed information about a product, including images, description, price, and reviews.

- **Wishlist**: Add products to your wishlist for future reference. Only registered users can use this feature.

- **Shopping Cart**: Add products to your shopping cart, adjust quantities, and view the total price.

- **Product Reviews and Ratings**: Leave reviews and ratings for products you've purchased.

- **Secure Authentication**: Secure user registration and authentication process. Email verification is required.

- **Profile Completion**: Users need to complete their profile by providing their name and shipping address to use certain features.

- **Checkout**: Purchase products by proceeding to the checkout screen. Choose from various payment options like credit card, bank transfer, and mobile banking.



## Installation
1. Clone this repository: `git clone https://github.com/hossain-eee/Project-Flutter-CraftyBay.git`
2. Change to the project directory: `cd ecommerce-app`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Usage
1. Register and log in to access the full range of features.
2. Explore product categories and view product details.
3. Add products to your wishlist or shopping cart.
4. Leave reviews and ratings for products you've purchased.
5. Complete your profile to unlock additional features like posting reviews.
6. Proceed to the checkout screen when you're ready to make a purchase.

## Screenshots
![App Screenshot 1](screenshots/screenshot1.png)
![App Screenshot 2](screenshots/screenshot2.png)
<!-- Add more screenshots here -->

## Used Packages
This app uses several Flutter packages to enhance its functionality. Below is a list of key packages used and how they are integrated:

- **flutter_svg: ^2.0.7**: Used to display SVG images in the app.

- **get: ^4.6.6**: Utilized for state management and app navigation.

- **pin_code_fields: ^8.0.1**: Implemented for OTP (One-Time Password) input functionality.

- **carousel_slider: ^4.2.1**: Used to create image carousels in the app.

- **http: ^1.1.0**: Utilized for making HTTP requests to retrieve data from remote servers.

- **get_storage: ^2.1.1**: Used for efficient local storage of data, including theme mode (light or dark), improving app performance.

- **shared_preferences: ^2.2.1**: Used for persisting user authentication status, ensuring users remain logged in between app sessions.

- **connectivity_plus: ^5.0.0**: Used to detect the device's network connectivity.

- **webview_flutter: ^4.4.1**: Integrated to display web content within the app.

## Theme Mode Persistence
This app allows users to switch between light and dark themes. The selected theme mode is persisted using the `get_storage` package, ensuring that users see their preferred theme even after app restarts.

## User Authentication Remember
The app uses the `shared_preferences` package to remember user authentication status. If a user logs in, the app will remember their login status, making it convenient for users to access their accounts without repeated logins.




### E-Commerce project structure 
Here used Layer architecture, here we divided layer into two part
-application --hold the file which broadcast information all over tha app like configuration, its an entry point of our app
-data -- hold data related operation like network. We will get data/information from this data(it would have file), we don't know where from coming information/data it will manage the file which is situated inside data folder. so in future if client want to change data/information source like firebase to database or database to firebase, we don't have any problem just change code inside the data folder then it will apply every where. If you don't use this operate file (inside data folder)  and code direct insdie app other file then every where need to change according to client demand which would so painful 
-presentation -- hold user's all visible things
-stat_holders-- getx all controller
-utility--color,style

.
└── app layer structure
├── lib/
│   ├── application
│   ├── data  
│   └── presentation/
│       ├── state_holders
│       └── ui/
│           ├── screens
│           ├── utlity
│           └── widgets
└── main.dart

app layer structure
└── lib/
    ├── application
    ├── data  
    └── presentation/
        ├── state_holders
            └── ui/
                ├── screens
                ├── utlity
                └── widgets
