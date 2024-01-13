# Mini Project 3 - An Interactive App

Create a restaurant/coffee shop ordering app using Flutter with these requirements:
1. App must have at least 2 screens
2. The first screen shows the full menu with prices (menu should have at least 3 items)
3. When a menu item is selected, it opens a new details screen with information about this menu item and at least 2 options to add e.g. toppings, sides, ... etc
4. The user can select from the options and add the menu item to the order
5. When a menu item(s) is/are added to the order, there is an indicator somewhere in the app that shows the total price of the order
6. The user can add as many items with options and the price is always updated

# Online Food-Order Mobile Application
The application contains Menu List Screen, Menu Detail Screen and Order Summary screen. The logic for the Menu List Screen can be found in menu_screen.dart, Menu Detail Screen in menu_item_details_screen.dart and Order Summary screen in order_screen.dart

The user will be able to select any food item and on clicking the '+' icon then the user will be navigated to the Menu Detail screen and based on the type of the food selected the size of food and options of the food drop-down value changes. There are also some checkbox values that can be selected for toppings/customization for the user based on the type of food. The quantity of the order can be decided either on the Menu Detail Screen or Order Summary screen. Once the user selects 'Add to Cart' button the user is navigated to the Menu List screen. The selected order will be available in the Order Summary screen and the user will be able to view the screen by clicking on the 'Cart' Icon on the Menu List Screen. The total amount will be displayed on the bottom of the Order Summary screen. "Checkout" button is not functional at the moment. Based on the size of the order selected and quantity selected the total amount for the order also varies.

![menuListScreen](https://github.com/Sumanth-Mahabaleshwar-Bhat/Online-Food-Order-MobileApplication/assets/120843537/775a8cf6-23c1-4a51-8689-024f5ce348eb)
![menuDetailScreen](https://github.com/Sumanth-Mahabaleshwar-Bhat/Online-Food-Order-MobileApplication/assets/120843537/60b0c483-96f6-4e0e-bb6b-3df23a70609c)
![orderSummaryPage](https://github.com/Sumanth-Mahabaleshwar-Bhat/Online-Food-Order-MobileApplication/assets/120843537/aab907ff-75c2-4090-adb1-5190895ba9a5)


