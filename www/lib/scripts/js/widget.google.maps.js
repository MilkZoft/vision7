$(document).ready( function() {
	$(".map_google").googlemaps({ width: "100%", height: "400px", zoom : 16 });
	$(".hotel_map_google").googlemaps({ width: "100%", height: "400px", zoom : 16, events: false });
});
	
var map      = "";
var marker 	 = "";
var geocoder = new google.maps.Geocoder();

$.widget("ui.googlemaps", {
	options: {
		width  : "200px",
		height : "200px",
		lat    : $('input[name="lat"]').val(),
		lng    : $('input[name="lng"]').val(),
		zoom   : 8,
		events : true
	},
	
	_create: function() {
		this.element.css({"width" : this.options.width, "height" : this.options.height});
		
		var pointcolima = new google.maps.LatLng(this.options.lat, this.options.lng);
		
		var myOptions = {
			zoom: 	   this.options.zoom,
			center:    pointcolima,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		
		map = new google.maps.Map(this.element.context, myOptions);
		
		marker = new google.maps.Marker({
			map:	   map,
			draggable: this.events,
			animation: google.maps.Animation.DROP,
			position:  pointcolima
		});
		
		if(this.events == true) {
			google.maps.event.addListener(marker, 'click', toggleBounce);
			google.maps.event.addListener(marker, 'dragend', getPoint);
		}
	}
});

function toggleBounce() {
	if (marker.getAnimation() != null) {
		marker.setAnimation(null);
	} else {
		marker.setAnimation(google.maps.Animation.BOUNCE);
	}
}

function getPoint() {
	var position = marker.getPosition();
	
	$("#lat").val(position.lat());
	$("#lng").val(position.lng());
	
	//codeLatLng(position);
}

function getAddress() {
	var numero    = $("#numero").val().replace(/ /g, "+");
	var calle     = $("#calle").val().replace(/ /g, "+");
	var colonia   = $("#colonia").val().replace(/ /g, "+");
	var municipio = $("#municipio").val().replace(/ /g, "+");
	var estado 	  = $("#estado").val().replace(/ /g, "+");
	var address   = numero + "+" + calle +"," + colonia + "," + municipio + "," + estado;
	
	geocoder.geocode({ 'address': address}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			
			map.setCenter(results[0].geometry.location);
			
			var pointmarker = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
			
			marker.setPosition(pointmarker);
			
			var latvalue = results[0].geometry.location.lat();
			var lngvalue = results[0].geometry.location.lng();
			
			$("#lat").val(results[0].geometry.location.lat());
			$("#lng").val(results[0].geometry.location.lng());
			
		} else {
			errMSG.innerHTML = "Problem: " + status;
		}
	});
}

function codeLatLng(latlng) {
	geocoder.geocode({'latLng': latlng}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			if (results[1]) {
				
				$("#numero").val(results[0].address_components[0].long_name);
				$("#calle").val(results[0].address_components[1].long_name);
				$("#colonia").val(results[0].address_components[2].long_name);
				$("#municipio").val(results[0].address_components[3].long_name);
				$("#estado").val(results[0].address_components[4].long_name);

			} else {
				alert("No results found");
			}
		} else {
			alert("Geocoder failed due to: " + status);
		}
	});
}

