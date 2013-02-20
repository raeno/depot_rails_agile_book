# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

      $('.store .entry > img').click ->
        $(this).parent().find(':submit').click();

      product_quantity = $('.product-quantity');
      product_quantity.click ->
          current = $(this)
          event.stopPropagation();
          current.parent().find('.items-count-spinner').show();
          current.find('.item-count').focus();
          position = current.position();


          $('.items-count-spinner').css({
            'top' : position.top - 5,
            'left' : position.left - 25,})

      $('body').click ->
        if ($(event.target).parents('.items-count-spinner').length == 0)
          $('.items-count-spinner').hide();