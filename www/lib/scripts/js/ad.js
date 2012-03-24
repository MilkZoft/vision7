var timeads = 7000;
var temp    = 0;

$(document).ready( function() {
	$(".ads").hide();
	$(".principal").show();	
	
	$('.div-ads').each(function(index) {
		var len = $("#" + $(this).attr("id") + " .ads").length;
		if(len > 1) {
			setTimeout("ads('#"+$(this).attr("id")+"')", timeads);
		}
	});
});

function ads(position) {
	var len = $(position + ' .ads').length;
	var ran = Math.floor(Math.random() * len);
	
	if(ran < len && ran > len ) {
		ads("'" + position + "'");
	} else if(ran == temp) {
		ads(position);
	} else {
		temp = ran;
		$(position + ' .ads').hide();
		$(position + ' .ads').eq(ran).fadeIn("slow");
		setTimeout("ads('" + position + "')", timeads);
	}
}
