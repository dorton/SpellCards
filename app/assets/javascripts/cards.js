$( document ).on('turbolinks:load', function() {

  $('.card').click(function(){
    $(this).toggleClass('flipped');

  });

  })
