function createMap(R, col) {
	var current = null;
	for (var state in col) {
		col[state].color = Raphael.getColor();
		(function (st, state) {
			
			st[0].style.cursor = "pointer";

			st[0].onmouseover = function () {
				
				for (var elem in col) {
					$('#'+elem).removeClass('on-over');
					$('#'+elem).addClass('on-out');			
				}
				
				$('#'+state).removeClass('on-out');
				$('#'+state).addClass('on-over');
				
				current && col[current].animate({fill: "#333", stroke: "#666"}, 500);
				
				st.animate({fill: st.color, stroke: "#ccc"}, 500);
				st.toFront();
				R.safari();
				
				current = state;
			};
			
			/* 
			st[0].onmouseout = function () {
				$('#'+state).removeClass('onOver');
				$('#'+state).addClass('onOut');
				st.animate({fill: "#333", stroke: "#666"}, 500);
				st.toFront();
				R.safari();
			};
			*/
			
		})(col[state], state);
	}
};