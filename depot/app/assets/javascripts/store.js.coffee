# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class CountSpinner
  _count_spinner: null

  constructor: ->

  subscribe: ->
    product_quantity = $('.product-quantity');
    me = @

    product_quantity.click ->
      product = $(this)
      event.stopPropagation();


      items_count_input = me.show_spinner(product)

      me.subscribe_to_left_arrow(product,items_count_input)
      me.subscribe_to_right_arrow(product,items_count_input)


  show_spinner: (current) ->
    position = current.position()

    @_count_spinner =  current.parent().find('.items-count-spinner');

    @_count_spinner.css({'top' : position.top - 5, 'left' : position.left - 25,})
    @_count_spinner.attr('data-product-id',current.attr('data-product-id'))

    @_count_spinner.show();

    @.update_input(current.text())

  hide_spinner: ->
    @_count_spinner.hide();


  update_input: (newValue) ->
    items_count = @_count_spinner.find('.item-count')
    items_count.val(newValue);
    items_count.focus();
    items_count

  subscribe_to_left_arrow: (product,items_count_input) ->
    me = @
    product.parent().find('.left-arrow').off('click').on('click', ->
      value = parseInt(items_count_input.val());
      if (value > 1)
        items_count_input.val(value - 1);

      me.remove_item_from_cart(product.attr('data-product-id'))
      me.hide_spinner();

    )

  subscribe_to_right_arrow:(product,items_count_input) ->
    me = @
    product.parent().find('.right-arrow').off('click').on('click', ->
      value = parseInt(items_count_input.val());
      items_count_input.val(value + 1);
      me.add_item_to_cart(product.attr('data-product-id'))
      me.hide_spinner();
    )

  add_item_to_cart: (product_id) ->
    $.ajax({
      type: "POST",
      url: '/line_items?product_id=' + product_id,
      headers: {
        Accept:"application/javascript"}
      })

  remove_item_from_cart: (product_id) ->
    $.ajax({
           type: "DELETE",
           url: '/line_items/' + product_id,
           headers: {
           Accept:"application/javascript"}
           })

$ ->
      $('.store .entry > img').click ->
        $(this).parent().find(':submit').click();

      window.spinner = new CountSpinner;
      window.spinner.subscribe();


      $('body').click ->
        if ($(event.target).parents('.items-count-spinner').length == 0)
          $('.items-count-spinner').hide();