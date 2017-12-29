settings.outformat = "pdf";

real arrow_len = 5;
real box_h = arrow_len / 3.0;
real box_w = box_h;
real box_count = 3;
real object_box_w = 2 * box_w;

real get_x0(int i) {
	return arrow_len * i + box_w * (i - 1);
}

real get_x1(int i) {
	return get_x0(i) + box_w;
}

real obj_x0 = get_x0(2) - box_w / 2.0;
real obj_x1 = obj_x0 + object_box_w;
real obj_y0 = 0;
real obj_y1 = box_h;

real eps = arrow_len / 10.0;

real obj_label_x = (obj_x0 + obj_x1) / 2.0;
real obj_label_y = (obj_y0 + obj_y1) / 2.0;

real box_y0 = obj_y1 + arrow_len;
real box_y1 = box_y0 + box_h;

real box_label_x_offset = box_w / 2.0;
real box_label_y_offset = box_h / 2.0;

real arrow_left_offset = box_h * 2.0 / 3.0;
real arrow_right_offset = box_h * 1.0 / 3.0;
real arrow_left_y = box_y0 + arrow_left_offset;
real arrow_right_y = box_y0 + arrow_right_offset;
real arrow_down_offset = box_w * 0.5;

real label_offset = box_h / 6.0;
size(15cm,0);

void draw_arrow(path p, real relative_pos, string text, align al) {
	draw(
    	L=Label(
    		scale(0.5)*("" + text + ""),
    		position=Relative(relative_pos),
    		gray,
    		align = al
    	),
    	p,
    	arrow=Arrow
    );
}

void draw_strait_arrows(real x0, real x1, real len = arrow_len) {
	real rel_pos = 0.75 + 0.22 * (1 - arrow_len / len);
    draw_arrow((x0 - len, arrow_left_y) -- (x0, arrow_left_y), rel_pos, "next", (E + N / 2.0));
    draw_arrow((x0, arrow_right_y) -- (x0 - len, arrow_right_y), rel_pos, "prev", (W - N / 2.0));
}

void draw_curved_arrow(pair p0, pair p3, string text, bool reversed = false) {
	real delta = arrow_len * (1.0 / 3.0);
	pair p1 = (xpart(p0) + delta, ypart(p0));
	pair p2 = (xpart(p3) - delta, ypart(p3));
	pair add = (arrow_len / 10.0, 0);
	if (reversed) {
		p1 -= add;
		p2 -= add - (0, box_h / 10.0);
	} else {
		p1 += add - (0, box_h / 10.0);
		p2 += add;
	}
	p2 += 0.3 * (p1 - p2);
	p1 -= 0.3 * (p1 - p2);
	pair p1_5 = (p1 + p2) / 2.0;

	//draw(circle(p1, 0.1), red);
	//draw(circle(p1_5, 0.1), magenta);
	//draw(circle(p2, 0.1), blue);

	path p = p0{right}..{down}p1{down}..{left}p1_5{left}..{down}p2{down}..{right}p3;
	draw_arrow(reversed ? reverse(p) : p, 0.938, text, reversed ? N : -N);

	pair q0 = p3 + box_w, q1 = p2 + (box_w + 2 * (xpart(p3) - xpart(p2)), 0), q3 = p0 + arrow_len, q2 = p1 + (arrow_len - 2 * (xpart(p1) - xpart(p0)), 0);
	pair q1_5 = (q1 + q2) / 2.0;

	//draw(circle(q1, 0.1), red);
	//draw(circle(q1_5, 0.1), magenta);
	//draw(circle(q2, 0.1), blue);

	p = q0{right}..{up}q1{up}..{left}q1_5{left}..{up}q2{up}..{right}q3;
	draw_arrow(reversed ? reverse(p) : p, 0.938, text, reversed ? N : -N);
}

void draw_arrow_to_obj(real x0, real y0) {
	pair p0 = (x0, y0);
	real obj_mid = (obj_x0 + obj_x1) / 2.0;
	pair p1 = (obj_mid + (x0 - obj_mid) / 1.5, obj_y1 + arrow_len / 2.0 - abs(x0 - obj_mid) / 7.0);
	pair p2 = (obj_mid+ (x0 - obj_mid) / 50.0, obj_y1);
	if (x0 == obj_mid) {
		draw(
			L=Label(
 				scale(0.5)*"ptr",
    			position=Relative(0.7),
    			gray,
    			align=-N + W * 0.7
    		),
    		p0 -- p2,
    		arrow=Arrow
    	);
	} else if (x0 < obj_mid) 
		draw(
			L=Label(
 				scale(0.5)*"ptr",
    			position=Relative(0.6),
    			gray,
    			align=-N
    		),
    		p0{down}..{right}p1{right}..{down}p2,
    		arrow=Arrow
    	);
	else
		draw(
			L=Label(
 				scale(0.5)*"ptr",
    			position=Relative(0.5),
    			gray,
    			align=-N
    		),
    		p0{down}..{left}p1{left}..{down}p2,
    		arrow=Arrow
    	);
}

void draw_box(real x0, real x1, int i, real y0 = box_y0, real y1 = box_y1, pen color=royalblue) {
	draw_arrow_to_obj(x0 + arrow_down_offset, y0);
 	path ptr = box((x0, y0), (x1, y1));
	fill(ptr, color);
	draw(ptr, black);
 	label("ptr" + string(i) + "", (x0 + box_label_x_offset, y0 + box_label_y_offset), white);
}

void draw_last_arrows() {
	int last_index = (int)box_count + 1;
	real last_x0 = get_x0(last_index) - arrow_len / 2;
	real last_x1 = get_x1(last_index) - arrow_len / 2;
	draw_strait_arrows(last_x0, last_x1, arrow_len / 2);
}


path obj = box((obj_x0,obj_y0), (obj_x1,obj_y1));
fill(obj, deepgreen);
draw(obj, black);
label("object", (obj_label_x, obj_label_y), white);


for (int i = 1; i <= box_count; ++i) {
	real x0 = get_x0(i), x1 = get_x1(i);
 	draw_strait_arrows(x0, x1, i == 1 ? arrow_len / 2 : arrow_len);
 	draw_box(x0, x1, i);
}
draw_last_arrows();