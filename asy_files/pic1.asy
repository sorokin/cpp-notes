settings.outformat = "pdf";

real arrow_len = 5;
real box_h = arrow_len;
real box_w = 2.0 * box_h;
real box_count = 3;
real object_box_w = box_count * box_w + (box_count + 1) * arrow_len;

real obj_x0 = 0;
real obj_x1 = obj_x0 + object_box_w;
real obj_y0 = 0;
real obj_y1 = box_h;

real obj_label_x = (obj_x0 + obj_x1) / 2.0;
real obj_label_y = (obj_y0 + obj_y1) / 2.0;

real box_y0 = obj_y1 + arrow_len;
real box_y1 = box_y0 + box_h;

real box_label_x_offset = box_w / 2.0;
real box_label_y_offset = box_h / 2.0;

real arrow_left_y = box_y0 + box_h * 2.0 / 3.0;
real arrow_right_y = box_y0 + box_h * 1.0 / 3.0;
real arrow_down_offset = box_w * 0.5;
size(10cm,0);

// green box:
path obj = box((obj_x0,obj_y0), (obj_x1,obj_y1));
fill(obj, green);
// it's label :
label("$O B J E C T$", (obj_label_x, obj_label_y), white);

for (int i = 1; i <= box_count; ++i) {  
 	real x0 = arrow_len * i + box_w * (i - 1);
 	real x1 = x0 + box_w;

	// blue box:
 	path ptr = box((x0, box_y0), (x1, box_y1));
	fill(ptr, blue);
 	// it's label:
 	label("$ptr" + string(i) + "$", (x0 + box_label_x_offset, box_y0 + box_label_y_offset), white);

 	// left arrows:
 	draw((x0 - arrow_len, arrow_left_y) -- (x0, arrow_left_y), arrow=Arrow);
	draw((x1, arrow_left_y) -- (x1 + arrow_len, arrow_left_y), arrow = Arrow);
	
	// right arrows:
	draw((x0, arrow_right_y) -- (x0 - arrow_len, arrow_right_y), arrow=Arrow);
	draw((x1 + arrow_len, arrow_right_y) -- (x1, arrow_right_y), arrow = Arrow);

	// down arrow:
	draw((x0 + arrow_down_offset, box_y0) -- (x0 + arrow_down_offset, box_y0 - arrow_len), arrow=Arrow);
}