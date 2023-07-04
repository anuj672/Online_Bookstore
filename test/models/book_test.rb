require "test_helper"

class BookTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "should not save book without name" do
     book = Book.new
     book.name = nil
     assert_not book.save
     #assert book.save will fail the test as the name is nil
   end

   test "price should be positive" do
     book = Book.new
     book.price = -5
     assert_not book.save
     #assert book.save will fail the test as the price is negative
   end

   test "stock should be positive" do
     book = Book.new
     book.stock = -5
     assert_not book.save
     #assert book.save #will fail the test as the sock is negative
   end

   test "author should be mentioned" do
     book = Book.new
     book.author = nil
     assert_not book.save
     #assert book.save #will fail the test as the author is nil
   end

end
