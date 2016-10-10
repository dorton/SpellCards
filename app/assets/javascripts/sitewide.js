$( document ).on('turbolinks:load', function() {
  // $(".button-collapse").sideNav({
  //   edge: 'right', // Choose the horizontal origin
  //   closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
  // });
  //
  // $('.dropdown-button').dropdown({
  //     inDuration: 300,
  //     outDuration: 225,
  //     constrain_width: false, // Does not change width of dropdown to that of the activator
  //     hover: true, // Activate on hover
  //     gutter: 0, // Spacing from edge
  //     belowOrigin: false, // Displays dropdown below the button
  //     alignment: 'left' // Displays dropdown with edge aligned to the left of button
  //   }
  // );

  // $('.dropdown-toggle').dropdown()
  $('#refresh').click(function() {
    location.reload();
});

})
