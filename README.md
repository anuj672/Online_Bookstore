# Online Bookstore

### Ruby & Rails Versions Required
The following Ruby & Rails versions are required to launch the application:

* Ruby Version 3.2.0
* Rails Version 7.0.4

### Setting up
Clone this repository
```
git clone https://github.com/anuj672/Online_Bookstore
```

Go to the directory:
```
cd Online_Bookstore
```

Install the required gems:
```
bundle install
```

Migrate the database:
```
rails db:migrate
```

Seed required data:
```
rails db:seed
```

Now you're ready to run the server:
```
rails s
```

With the server running, visit [http://localhost:3000](http://localhost:3000) to access the Online Bookstore application.

### Admin Credentials
Username: ```admin``` </br>
Password: ```password```

## Rails Model Dependecy Diagram
   <img src="Rails Model Dependency Diagram.png" width="450">
   
## Navigating the Online Bookstore Application
The following sections outline how to navigate the Online Bookstore application to perform various actions. At any time, the 'Home page' link can be clicked at the top of the page to navigate back to the home page.

### Signing up as a new user
1. After running the server, visit [http://localhost:3000](http://localhost:3000) to reach the homepage of the application. </br>
2. Use the "Signup" link to create a new account.</br>
   <img src="https://media.github.ncsu.edu/user/23472/files/f41ded25-41cc-4ce9-a131-f9fa06300501" width="350">
3. Input values into the following fields:
   - Username (required)
     - *Note: Cannot choose a username that is already taken.*
     - *Note: Cannot choose 'admin' as a username because it is reserved for the admin user.*
   - Password (required)
   - Name (required)
   - Email (required)
     - *Note: Must be in valid email format.*
     - *Note: Must be unique in that it cannot be the email of another user.*
   - Address
   - Credit card number
     - *Note: Must be only numeric values.*
   - Phone Number
        - *Note: Must in 'XXX-XXX-XXXX' format.*
4. If values inputted are legal, upon clicking the "Create User" button, you will be redirected to the homepage with the message "User was successfully created."

### Logging in
1. After running the server, visit [http://localhost:3000](http://localhost:3000) to reach the homepage of the application. </br>
2. Use the "Login" link to login as an existing user or admin.</br>
   <img src="https://media.github.ncsu.edu/user/23472/files/80597627-34f5-4256-bd1f-e611b6fc9ad1" width="350">
3. Input a valid set of username and password.
   - If the username or password is invalid, you will not be able to login and instead get the message "Username or password is invalid."</br>
4. After inputting valid credentials, click the "Login" button complete the login process. You will be navigated to the logged in homepage, the links available on the home page will depend on whether you are logged in as a user or an admin.</br>

### Logging out
To log out, click the "Logout" link found on the home page. This link is at the bottom of the list of links for both users and the admin:<br>
   <img src="https://media.github.ncsu.edu/user/23472/files/1ece3877-4410-46e6-990f-585bd0abce23" width="350">

### Capabilities of Both Users and the Admin:
The following can be done when logged in as either a user or the admin:
#### 1. View All Books
From the home page, click "View Books."<br/>
##### Search features of this page:
On the [View All Books](#2-view-all-books) page, you have the ability to search books in two ways: (1) by author and (2) by listing books with an average rating greater than the inputted value. Use the "Clear Search" link under the search boxes to view the unfiltered list of books again.
##### Sort features of this page:
On the [View All Books](#2-view-all-books) page, you have the ability to sort books by 'Title' or 'Author' by clicking on their column headings.
#### 2. Show a Book
From the [View All Books](#2-view-all-books) page, click 'View Details' next to the book you would like to see.
#### 3. Create a Review
1. From the [View All Books](#2-view-all-books) page, click 'Write a Review' next to the book you'd like to write a review for. A second way to write a review is by using the 'Write a review for this book' link from the book show page.
2. Input values for the following fields:
   - Rating (required)
      - *Note: Rating must be an integer between 1 and 5.*
   - Review (required)
3. Upon successfully creating a review, you will be redirected to the [View All Reviews](#6-view-all-reviews) page with the message "Review was successfully created."
#### 4. View All Reviews
From the home page, click "View Reviews."<br/>
##### Search features of this page:
On the View All Reviews page, you have the ability to search books in two ways: (1) by book name and (2) by username of the user who wrote the review. Use the "Clear Search" link under the search boxes to view the unfiltered list of reviews again.
#### 5. Show a Review
From the [View All Reviews](#4-view-all-reviews) page, click 'Show' next to the review you would like to see.
#### 6. Edit a Review
From the [View All Reviews](#4-view-all-reviews) page, click 'Edit' next to the review you would like to edit.<br><br>
*Note: Users are not able to edit reviews of other users so they do not see a link to edit present on reviews that are not their own. This differs from the permissions of the admin who can edit all reviews, regardless of if it is the admin's review or a review of another user.*
#### 7. Edit Your Own Profile
From the home page, click "Edit Profile."<br><br>
*Note: Users are able to update any information on their profile, while admins cannot edit their username or password but can edit their name and email.*<br/><br/>
*Note: All field validations are the same as the validations described in step 3 of the "[Signing up as a new user](#signing-up-as-a-new-user)" section.*

### Admin Capabilities:
If logged in using the credentials found in the "[Admin Credentials](#admin-credentials)" section, you will have access to do the following in addition to the capabilities listed in the "[Capabilities of Both Users and the Admin](#capabilities-of-both-users-and-the-admin)" section:

#### 1. Create a Book
1. From the home page, click "View Books."<br/>
2. Click "New Book."<br/>
3. Input values for the following fields:
   - Name (required)
   - Author (required)
   - Publisher (required)
   - Price (required)
      - *Note: Price must be a non-negative float.*
   - Stock (required)
      - *Note: Stock must be a non-negative integer.*
4. If values entered are valid, the button "Create Book" will create the book and redirect you to the home page with the message "Book was successfully created."
#### 2. Edit a Book
From the [View All Books](#1-view-all-books) page, click 'Edit' next to the book you'd like to edit. A second way to edit the book is by using the 'Edit this book' link from the [book's show page](#4-edit-a-book).<br><br>
When editing a book, the field validations outlined in the "[Create a Book](#1-create-a-book)" section remain the same. Click the "Update Book" button when finished updating the attributes. If the inputs are valid, you will be redirected to the home page with the message "Book was successfully updated."
#### 3. Delete a Book
1. Click the "View Book" link from the home page
2. Click the "Destroy" button next to the book you would like to delete.
3. Then click "Destroy" again.
4. You will be re-directed to the home page with the message "Book was successfully destroyed."<br/><br/>
*Note: When deleting a book, all of its associated reviews, transactions, and cart items will also be deleted.*
#### 4. Delete a Review
1. Click the "View Reviews" link from the home page
2. Click the "Destroy" button next to the book you would like to delete.
3. Then click "Destroy" again.
4. You will be re-directed to the home page with the message "Review was successfully destroyed."
#### 5. Create a User
1. From the home page, click "View Users."<br/>
2. Click "New User."<br/>
   - Username (required)
     - *Note: Cannot choose a username that is already taken.*
     - *Note: Cannot choose 'admin' as a username because it is reserved for the admin user.*
   - Password (required)
   - Name (required)
   - Email (required)
     - *Note: Must be in valid email format.*
     - *Note: Must be unique in that it cannot be the email of another user.*
   - Address
   - Credit card number
     - *Note: Must be only numeric values.*
   - Phone Number
        - *Note: Must in 'XXX-XXX-XXXX' format.*
4. If values entered are valid, the button "Create User" will create the user and redirect you to the home page with the message "User was successfully created."
#### 6. View All Users
From the home page, click "View Users."<br/>
#### 7. Show & Edit Users
1. From the home page, click "View Users."
2. Click "View User Details" next to the user you would like to view.
3. If you would like to additionally edit the user, click the "Edit this user" link.
4. Make the updates you would like while staying within teh validations outlined in the "[Create a User](#5-create-a-user)" section.
5. Click "Update" user when finished. If the inputs are valid, you will be redirected to the user's show page with the message "User was successfully updated."
#### 8. Delete a User
1. From the home page, click "View Users."
2. Click "View User Details" next to the user you would like to delete.
3. Click the "Destory this user" button.
4. Upon successful deletion, you will be redirected to the home page with the message "User was successfully deleted."<br><br>
*Note: When deleting a user, all of their associated reviews, transactions, cart, and cart items in that cart will also be deleted.*

### User Capabilities:
If logged in as a user, you will have access to do the following in addition to the capabilities listed in the "[Capabilities of Both Users and the Admin](#capabilities-of-both-users-and-the-admin)" section:
#### 1. Purchase a Book
1. From the [View All Books](#1-view-all-books) page, click 'Buy Now' next to the book you'd like to purchase. A second way to purchase the book is by using the 'Buy Now' link from the [book's show page](#4-edit-a-book).<br><br>
2. Input values for the following fields:
   - Quantity (required)
      - *Note: Must be a non-negative integer equal to or less than the book's available stock.*
   - Total price (required)
      - *Note: Must be a non-negative float.*
      - *Note: This is automatically calculated and rendered as read-only so it does not require manual input.*
   - Credit card number (required)
      - *Note: Must be only numeric values.*
      - *Note: This value is pre-filled from the information on the user's profile.*
   - Address (required)
      - *Note: This value is pre-filled from the information on the user's profile.*
   - Phone number (required)
      - *Note: Must in 'XXX-XXX-XXXX' format.*
      - *Note: This value is pre-filled from the information on the user's profile.*
3. If inputs are legal, clicking 'Complete Purchase' will create a transaction and re-direct you to that transaction's show page with the message "Transaction was successfully created."
#### 2. Add a Book to Your Cart
1. From the [View All Books](#1-view-all-books) page, click 'Add to Cart' next to the book you'd like to purchase. If the book is already in your cart, a link that says 'View in Cart' displays instead. A second way to add a book to your cart is by using the 'Add to Cart' link from the [book's show page](#4-edit-a-book).<br><br>
2. Input values for the following fields:
   - Quantity (required)
      - *Note: Must be a non-negative integer equal to or less than the book's available stock.*
   - Total price (required)
      - *Note: Must be a non-negative float.*
      - *Note: This is automatically calculated and rendered as read-only so it does not require manual input.*
3. If inputs are legal, clicking 'Add to Cart' will create a cart item and re-direct you to that cart item's show page with the message "Cart item was successfully created."
#### 3. View Your Cart
From the home page, click "View My Cart." There is also a 'View My Cart' link on the [View All Books](#1-view-all-books) page.
#### 4. Edit & Remove Items in Your Cart
From the "[View My Cart](#3-view-your-cart)" page, use the "Edit" link next to the cart item you would like to update to edit. When editing, the validations remain the same as the ones outlined in step 2 of section "[Add a Book to Your Cart](#2-add-a-book-to-your-cart)."<br><br>
To remove an item, use the "Remove from cart" button next to the cart item you would like to remove. This will delete the cart item.
#### 5. Purchase Items from Your Cart
1. From the "[View My Cart](#3-view-your-cart)" page, click "Continue to Checkout."
2. Input values for the following fields:
   - Credit card number (required)
      - *Note: Must be only numeric values.*
      - *Note: This value is pre-filled from the information on the user's profile.*
   - Address (required)
      - *Note: This value is pre-filled from the information on the user's profile.*
   - Phone number (required)
      - *Note: Must in 'XXX-XXX-XXXX' format.*
      - *Note: This value is pre-filled from the information on the user's profile.*
3. Click "Complete Purchase" to purchase the items in your cart. This will create a transaction for each cart item and clear each item as the transaction is created for it.
4. Once complete, you will be redirected to the home page with the message "Purchase successful."
*Note: The purchase will only be successful if the quantity requested is available in the book's stock. If the quantity requested is greater than the available stock, the purchase will halt and request for the quantity to be adjusted before proceeding.*
#### 6. View Your Purchase History
From the home page, click "View My Purchase History."<br><br>
*Note: This page will only show your purchase history. As a user, you cannot view other users' purchase history.*


## How to run the test suite
The tests have been added for one controller and one model.
Tests added for book model -

1. check if book has a name -  checks if the name of the book is present and passes the test if the the name is not present. To make the test fail the assert_not will have to be changed to assert.
2. Check if stock is negative -checks if the stock price is negative and passes the test if the stock is negative . To make the test fail the assert_not will have to be changed to assert.
3. Check if price is negative - checks if the price of the book is negative and passes the test if the  price is negative. To make the test fail the assert_not will have to be changed to assert.
4. author should be mentioned - checks if the name of the book is present and passes the test if the author name is not mentioned. To make the test fail the assert_not will have to be changed to assert.

To run the tests for model
1. Locate the test directory. Then go to models.
2. In models go to book_test.rb file  -> link  (https://github.ncsu.edu/vchheda/Online_Bookstore/blob/main/test/models/book_test.rb)
3. In the file make a note of the line on which the test you want to run is mentioned. For example the test to check if a book name is mentioned on line 8
4. To run the tests locally, open the command prompt, ensure you are in the application and add $rails test test/models/book_test.rb:8 
5. If the test runs with assertion, it is sucessful.

Tests added for User Controller -

1. Check whether the user is able to view the purchase history.
2. Check whether the user is able to view reviews.
3. Check whether user is able to add a book in the cart.
4. Check whether user is able to use buy now to purchase the book directly.

To run the tests for Controller - 

1. Locate the test directory. Then go to controllers.
2. In models go to book_test.rb file  -> link  (https://github.ncsu.edu/vchheda/Online_Bookstore/blob/main/test/controllers/users_controller_test.rb)
3. In the file make a note of the line on which the test you want to run is mentioned.
4. To run the tests locally, open the command prompt, ensure you are in the application and add $rails test test/controllers/users_controller_test.rb:8 
5. If the test runs with assertion, it is sucessful.
