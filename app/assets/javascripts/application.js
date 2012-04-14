// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


var google_map = null;
$(document).ready(function() {

  var init_gmap_opts = {
    zoom:8,
    center: new google.maps.LatLng(-34.37708183,-55.23834238),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var gmap = document.getElementById("gmap");
  
  if(gmap != null) {
    google_map = new google.maps.Map(gmap, init_gmap_opts);
  }

});

/** 
 * Render a marker on the given map.
 * */
function renderMarker(map, m) {
  var marker = new google.maps.Marker({
              position: new google.maps.LatLng(m.coords[0],m.coords[1]),
              map:map,
              title: "Tweets from this place: " + m.weight,
              visible:true,
              m_id:m.id
          });


  //Displays a text box, need to improve on the information shown here...
  google.maps.event.addListener(marker,'click', function() {
      var html = "<div>";
      if(m.weight == 1) {
          html += "The user only tweeted once from his location";
      } else {
          html += "The user tweeted " + m.weight + " times from this location";
      }
      html += "</div>";

      //Display the tweets from this location
      $("#empty-tweet-list").hide();
      $(".tweet-list").hide();
      $("." + marker.m_id).show();

      if(map.info_window_opened != null) {
          map.info_window_opened.close();
      }
      map.info_window_opened = new google.maps.InfoWindow( {content: html});
      map.info_window_opened.open(map,marker);
  });
  
/*
 //Using circles instead of standard markers...
 var opts = {
      strokeColor: "#FF0000",
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: "#FF0000",
      fillOpacity: 0.35 * m.weight,
      map: map,
      center: new google.maps.LatLng(m.coords[0], m.coords[1]),
      //radius: m.weight * 1000
      radius: 1000
    };
    cityCircle = new google.maps.Circle(opts);
*/


}
