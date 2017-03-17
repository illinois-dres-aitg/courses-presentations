
    function submitOrder(event) {
    
      clearErrorFeedback();
    
      var errors = [];

      event.stopPropagation();
      event.preventDefault();
      
      // Check for errors
      
      if ($("#id-name").val().length === 0) {
        errors.push({ id: 'id-name', message: "Name cannot be empty!  Enter your name"});        
      }

      if ($("#id-address").val().length === 0) {
        errors.push({ id: 'id-address', message: "Address cannot be empty! Enter your address"});        
      }
      
      var phone = $("#id-phone").val();
      if (phone.length === 0) {
        errors.push({ id: 'id-phone', message: "Phone cannot be empty! Enter your phone number"});        
      }
      else {
        p = "";
        for (var i = 0; i < phone.length; i++) {
          var c = phone[i];
          if ((c >= "0") && (c <= "9")) { 
            p += c;
          }
        }        
        if ((p.length !== 7) && (p.length !== 10)) {
          errors.push({ id: 'id-phone', message: "Not a vaild phone number, use (111) 222-3333"});        
        }
      }
      
      var crust = $('input[type="radio"][name="crust"]:checked');
      
      if ($(crust).length === 0) {
        errors.push({ id: 'id-crust', message: "You must select a crust!"});        
      }
      
      if (errors.length) {
        exampleErrorFeedback(errors);
      }
      else {
        $( "form" ).children().css('display', 'none');  
      
        $('div#order').append('<h2><a href="#" id="id-order"></a>Order information</h2>');
        $('div#order').append('<dl>');
        $('div#order').append('  <dt>Customer</dt>');
        $('div#order').append('  <dd>' + $("#id-name").val() + '</dd>');
        $('div#order').append('  <dd>' + $("#id-address").val() + '</dd>');
        $('div#order').append('  <dd>' + $("#id-phone").val() + '</dd>');
        $('div#order').append('  <dt>Delivery</dt>');
        $('div#order').append('  <dd>' + $("#id-delivery").val() + '</dd>');
        $('div#order').append('  <dt>Pizza</dt>');
        $('div#order').append('  <dd>' + $('input[type="radio"][name="crust"]:checked').val() + ' crust</dd>');
        
        // Get toppings
        
        var toppings = $('input[type="checkbox"][name="topping"]:checked');
        var first = true;
        var str = "";
        var count = $(toppings).length;
        
        $(toppings).each( function() {
          if (!first) {
            str += ", "; 
          } 
          first = false;
          str += $(this).val();
        }); 
        
        $('div#order').append("  <dd>" + (count === 1 ? "1 Toppings: " : count + " Toppings: ") + str + "</dd>");
      
        $('div#order').append("<dl>");
        
        $('a#id-order').focus();
      }
    
    }
