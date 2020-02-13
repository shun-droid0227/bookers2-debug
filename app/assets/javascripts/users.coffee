# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#user_zipcode").jpostal({
    postcode : [ "#user_zipcode" ],
    address  : {
                  "#user_prefecture_code" : "%3",
                  "#user_address"            : "%4%5%6%7"
                }
  })