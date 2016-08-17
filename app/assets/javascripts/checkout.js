jQuery(function($) {

  var stripeResponseHandler = function(status, response) {
     var $form = $('#payment-form');
     if (response.error) {
       // Show the errors on the form
       $form.find('.payment-errors').text(response.error.message);
       $form.find('button').prop('disabled', false);
     } else {
       // token contains id, last4, and card type
       var token = response.id;
       console.log(response);
       $(".card-token").val(token);
       $(".card-number").remove();
       $(".card-cvc").remove();

      //  // Insert the token into the form so it gets submitted to the server
       $form.append($('<input type="hidden" name="stripeToken" />').val(token));
       $form.append($('<input type="hidden" name="stripeEmail" />').val(email));
      //  // and re-submit
       $form.get(0).submit();
     }
   };

  $('#payment-form').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    // Stripe.card.createToken($form, stripeResponseHandler);

    Stripe.card.createToken({
      number: $('.card-number').val(),
      cvc: $('.card-cvc').val(),
      exp_month: $('.card-expiry-month').val(),
      exp_year: $('.card-expiry-year').val()
    }, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
});
