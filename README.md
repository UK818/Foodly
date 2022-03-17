# Foodly

Food Delivery Application is a mobile application that users can use to find the best restaurant around their location and order the meals they desire from the comfort of their home. One of the unique services of this product is that it targets only healthy restaurants so only high quality food with the healthiest benefits is offered to users at affordable cost. Do you want to loose weight or simply stay healthy? Let FitFood help you meet your weight loss goal and cut off that bad fat that increases your cholesterol level due to poor food choices. We offer only the best food choices.

# Requirements
- iOS ~> 14.5
- Xcode ~> 12 (9.3 compatible)
- Swift ~> 4.2

#Installation

Clone the repository

```
$ git clone https://github.com/UK818/Foodly.git
$ cd Foodly
$ cd Foodly
$ pod install
```

Open the file ```Foodly.xcworkspace``` using Xcode Click on the play button at the top left corner to build and run the project


# <h3> ONBOARDING </h3>

On installing the app, the user is taken to the onboarding screen as a first time user where the user gets to see details about the app. The user also has the choice to skip the entire onboarding process or move through the whole process. There are three slides showing details about the app and the user can move through them by swiping with the fingers or clicking on the next button. At the last slide, the button text changes from "Next" to "Get Started".


<img src = "https://user-images.githubusercontent.com/32143087/158728989-22fd5da7-8753-4cad-ab18-4e0c2bc54b70.png" width = "350" height = "700"/> <img src = "https://user-images.githubusercontent.com/32143087/158728985-d314a5da-820c-4829-9ff7-40bdaaf2d493.png" width = "350" height = "700"/>
<img src = "https://user-images.githubusercontent.com/32143087/158728981-17f5715f-bd95-4bbf-ab1b-53e23628d148.png" width = "350" height = "700"/> <img src = "https://user-images.githubusercontent.com/32143087/158728965-f5b4cf19-4c1d-45cf-9321-079234845df6.png" width = "350" height = "700"/>

# <h3> LOGIN </h3>

From the onboarding screen, the user is taken to the Login screen and for a new user without account, there is a Register button on the screen that takes them to where they can create a new account. There is an email and a password field where user enters their details and these fields are validated.

<img src = "https://user-images.githubusercontent.com/32143087/158729918-493e17ea-d7ce-43b1-a57d-c54b5031b38b.png" width = "350" height = "700"/>

# <h3> CREATE ACCOUNT </h3>

On clicking on the Register button, the user is taken to the "Create New Account" screen where the user gets to create a new account with email, password and fullname. Just like the login screen, these fields are all validated to make sure:

- The user enters the first name and last name
- A valid email address
- A strong password that contains numbers, alphabets and special characters.
- None of the fields is empty.

<img src = "https://user-images.githubusercontent.com/32143087/158730337-603250c4-fee5-4d54-a9b5-595f10c6a0ef.png" width = "350" height = "700"/>

# <h3> DASHBOARD </h3>

On successful login or creation of account, the user is welcomed to the dashboard which contains four tabs:

- The home displaying a welcome message, a filter for food categories and a list of popular restaurants
- A search tab that allows users to search for foods and restaurants
- An order history tab that displays the list of all orders that the user has ever made
- A profile tab where users can update their details such as address and phone number as well as log out from the app

<img src = "https://user-images.githubusercontent.com/32143087/158730699-49d2c382-9b72-4aff-825b-d50cb2d2ae26.png" width = "350" height = "700"/> <img src = "https://user-images.githubusercontent.com/32143087/158730684-32ccd1db-8115-4040-911e-d9fad66e58da.png" width = "350" height = "700"/> <img src = "https://user-images.githubusercontent.com/32143087/158730678-23d3dccc-d51d-4e46-828e-8f2ef2476ed6.png" width = "350" height = "700"/>

# <h3> ORDERING FOOD </h3>

To order food, the user can search by food name or restaurant name or use the food category filter at the top. On selecting any of the restaurants, the user is taken to the restaurant page and gets to see the foods sold by the restaurant and then make an order for any food of choice. Clicking on the add button besides each food adds the food the user's cart where the user gets to see the total price.

<img src = "https://user-images.githubusercontent.com/32143087/158731061-008a1740-d7a3-4253-837c-701a5d66dc1d.png" width = "350" height = "700"/> <img src = "https://user-images.githubusercontent.com/32143087/158731054-1caa0070-5883-4c44-8422-57c72cb8b433.png" width = "350" height = "700"/>

When the user is satisfied with the items in the cart, the user can click on the view cart button and is taken to another page where they see the items in their cart. In this page, the user gets to either confirm or change the address they want the food delivered to, the quantity of each food item as well as get a discount if they have a coupon code to apply.

<img src = "https://user-images.githubusercontent.com/32143087/158731704-1db81c66-069c-4a67-89e4-786d4bc25fa2.png" width = "350" height = "700"/>

Satisfied, the user can click on the continue button and is taken to the final checkout page where the user gets to see how long it will take to get the food delivered as well as who the delivery person is. The contact of the delivery person is also made available for events such as the food not being delivered at the right time.

<img src = "https://user-images.githubusercontent.com/32143087/158731854-72928ad6-dec1-4f7c-b6f7-17d399a47a97.png" width = "350" height = "700"/> <img src = "https://user-images.githubusercontent.com/32143087/158731844-ff180141-44dd-4f90-8c94-5c99697e4231.png" width = "350" height = "700"/>
