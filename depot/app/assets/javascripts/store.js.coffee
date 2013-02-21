# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class CountSpinner

  _count_spinner: null
  _items_count: null

  constructor: ->

  subscribe: ->
    product_quantity = $('.product-quantity');
    me = @

    product_quantity.click ->
      product = $(this)
      event.stopPropagation();

      me.show_spinner(product)
      items_count_input =  me.update_input(product.text())

      me.subscribe_to_left_arrow(product,items_count_input)
      me.subscribe_to_right_arrow(product,items_count_input)

      position = product.position();

      $('.items-count-spinner').css({
                                    'top' : position.top - 5,
                                    'left' : position.left - 25,})
  show_spinner: (current) ->
    @_count_spinner =  current.parent().find('.items-count-spinner');
    @_count_spinner.show();

  update_input: (newValue) ->
    items_count = @_count_spinner.find('.item-count');
    items_count.val(newValue);
    items_count.focus();
    items_count

  subscribe_to_left_arrow: (product,items_count_input) ->
    product.parent().find('.left-arrow').off('click').on('click', ->
      value = parseInt(items_count_input.val());
      if (value > 1)
        items_count_input.val(value - 1);
      else
        alert 'TODO: remove item from cart'
    )

  subscribe_to_right_arrow:(product,items_count_input) ->
    product.parent().find('.right-arrow').off('click').on('click', ->
      value = parseInt(items_count_input.val());
      if (value < 999)
        items_count_input.val(value + 1);
      else
        alert 'TODO: show too_much_elements error'
    )


$ ->
      $('.store .entry > img').click ->
        $(this).parent().find(':submit').click();

      window.spinner = new CountSpinner;
      window.spinner.subscribe();


      $('body').click ->
        if ($(event.target).parents('.items-count-spinner').length == 0)
          $('.items-count-spinner').hide();