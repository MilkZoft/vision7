$(document).ready(function() {
	setTimeout("animation()",300);
});
		
function animation() {
	cloud1();
	cloud2();
	cloud3();
	cloud4();
	cloud5();
}

function cloud1() {
	if(screen.width > 1280) {
		$("#cloud1").animate({left:"-=1350px"}, 8000).animate({left:"982px"}, 0)
	} else if(screen.width == 1280) {
		$("#cloud1").animate({left:"-=1184px"}, 8000).animate({left:"950px"}, 0)
	} else {
		$("#cloud1").animate({left:"-=1500px"}, 8000).animate({left:"800px"}, 0)
	}
	
	setTimeout("cloud1()", 8000);
}

function cloud2() {
	if(screen.width > 1280) {
		$("#cloud2").animate({left:"-=1350px"}, 9000).animate({left:"982px"}, 0)
	} else if(screen.width == 1280) {
		$("#cloud2").animate({left:"-=1184px"}, 9000).animate({left:"950px"}, 0)
	} else {
		$("#cloud2").animate({left:"-=1500px"}, 9000).animate({left:"800px"}, 0)
	}
	
	setTimeout("cloud2()", 9000);
}

function cloud3() {
	if(screen.width > 1280) {
		$("#cloud3").animate({left:"-=1350px"}, 10000).animate({left:"982px"}, 0)
	} else if(screen.width == 1280) {
		$("#cloud3").animate({left:"-=1164px"}, 10000).animate({left:"900px"}, 0)
	} else {
		$("#cloud3").animate({left:"-=1500px"}, 10000).animate({left:"800px"}, 0)
	}
	
	setTimeout("cloud3()", 10000);
}

function cloud4() {
	if(screen.width > 1024) {
		$("#cloud4").animate({left:"-=1350px"}, 11000).animate({left:"982px"}, 0)
	} else if(screen.width == 1280) {
		$("#cloud4").animate({left:"-=1184px"}, 11000).animate({left:"900px"}, 0)
	} else {
		$("#cloud4").animate({left:"-=1500px"}, 11000).animate({left:"800px"}, 0)
	}
	
	setTimeout("cloud4()", 11000);
}

function cloud5() {
	if(screen.width > 1024) {
		$("#cloud5").animate({left:"-=1350px"}, 12000).animate({left:"982px"}, 0)
	} else if(screen.width == 1280) {
		$("#cloud5").animate({left:"-=1164px"}, 12000).animate({left:"900px"}, 0)
	} else {
		$("#cloud5").animate({left:"-=1500px"}, 12000).animate({left:"800px"}, 0)
	}
	
	setTimeout("cloud5()", 12000);
}
