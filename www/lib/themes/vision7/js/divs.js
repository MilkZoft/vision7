$(document).ready(function(){
	$('#v-block2 #video-list .video img').click(function() {
		$('#video-full object embed').attr('src', $(this).attr('id') + '&autoplay=1');
	});
});

function showDiv(obj, div, container, type) {
	$('#' + container + ' ul li a').removeClass('menu-active');
	$('#' + container + ' ul li a').addClass('menu-inactive');
	$('#' + obj).removeClass('menu-inactive');
	$('#' + obj).addClass('menu-active');
	$('.' + type).addClass('no-display');
	$('#' + div).removeClass('no-display');
};