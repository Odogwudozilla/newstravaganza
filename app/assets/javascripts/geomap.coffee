# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# @initMap = ->
#   center =
#     lat: 0
#     lng: 0
#
#     map = new (google.maps.Map) $('#map')[0]
#     zoom: 2
#     center: center
#
#     $.getJSON 'all_countries.json', (jsonData) ->
#       $.each jsonData, (key, data) ->
#         LatLng = new (google.maps.LatLng)(data.lat, data.lng)
#         marker = new (google.maps.Marker)
#         position: LatLng
#         map: map
#         title: data.title
