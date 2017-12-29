settings.outformat = "pdf";

real linked = 1187;
real shared = 3527;
real intrusive = 996;
real unique = 786;
real linked_disp = 5;
real shared_disp = 51;
real intrusive_disp = 18;
real unique_disp = 12;real bench_width = 1624.0;
real max_height = 3527;

real arrow_offset = bench_width / 4.0 * 1.1;
real point_offset = arrow_offset * 2 / 3;
real linked_offset = arrow_offset + bench_width;
real shared_offset = arrow_offset + 2 * bench_width;
real intrusive_offset = arrow_offset + 3 * bench_width;
real unique_offset = arrow_offset + 4 * bench_width;
real label_offset = (shared_offset - linked_offset) / 2.0;

size(20cm,0);
draw((arrow_offset / 2, 0) -- (arrow_offset / 2, max_height),arrow=Arrow);

label(
	scale(0.5) * ("" + string(linked) + ""),
	(point_offset, linked),
	gray
);
label(
	scale(0.5) * ("" + string(shared) + ""),
	(point_offset, shared),
	gray
);
label(
	scale(0.5) * ("" + string(intrusive) + ""),
	(point_offset, intrusive),
	gray
);
label(
	scale(0.5) * ("" + string(unique) + ""),
	(point_offset, unique),
	gray
);
path lin = box((arrow_offset,0), (linked_offset,linked));
fill(lin, deepgreen);

path sha = box((linked_offset,0), (shared_offset,shared));
fill(sha, royalblue);

path intr = box((shared_offset,0), (intrusive_offset,intrusive));
fill(intr, magenta);

path uniq = box((intrusive_offset,0), (unique_offset,unique));
fill(uniq, heavyred);

real disp_eps = bench_width / 20.0;
draw(
	(arrow_offset, linked) 
	-- (arrow_offset, linked + linked_disp) 
	-- (arrow_offset + disp_eps, linked + linked_disp) 
	-- (arrow_offset - disp_eps, linked + linked_disp) 
	-- (arrow_offset, linked + linked_disp)
	-- (arrow_offset, linked - linked_disp)
	-- (arrow_offset + disp_eps, linked - linked_disp) 
	-- (arrow_offset - disp_eps, linked - linked_disp) 
	-- (arrow_offset, linked - linked_disp)
, gray);
draw(
	(linked_offset, shared) 
	-- (linked_offset, shared + shared_disp) 
	-- (linked_offset + disp_eps, shared + shared_disp) 
	-- (linked_offset - disp_eps, shared + shared_disp) 
	-- (linked_offset, shared + shared_disp)
	-- (linked_offset, shared - shared_disp)
	-- (linked_offset + disp_eps, shared - shared_disp) 
	-- (linked_offset - disp_eps, shared - shared_disp) 
	-- (linked_offset, shared - shared_disp)
, gray);
draw(
	(shared_offset, intrusive) 
	-- (shared_offset, intrusive + intrusive_disp) 
	-- (shared_offset + disp_eps, intrusive + intrusive_disp) 
	-- (shared_offset - disp_eps, intrusive + intrusive_disp) 
	-- (shared_offset, intrusive + intrusive_disp)
	-- (shared_offset, intrusive - intrusive_disp)
	-- (shared_offset + disp_eps, intrusive - intrusive_disp) 
	-- (shared_offset - disp_eps, intrusive - intrusive_disp) 
	-- (shared_offset, intrusive - intrusive_disp)
, gray);
draw(
	(intrusive_offset, unique) 
	-- (intrusive_offset, unique + unique_disp) 
	-- (intrusive_offset + disp_eps, unique + unique_disp) 
	-- (intrusive_offset - disp_eps, unique + unique_disp) 
	-- (intrusive_offset, unique + unique_disp)
	-- (intrusive_offset, unique - unique_disp)
	-- (intrusive_offset + disp_eps, unique - unique_disp) 
	-- (intrusive_offset - disp_eps, unique - unique_disp) 
	-- (intrusive_offset, unique - unique_disp)
, gray);

real label_delta = 0.03 * max(max(linked, shared), max(intrusive, unique));
label("linked\underline{\hspace{0.3cm}}ptr", (linked_offset - label_offset, linked + label_delta));
label("std::shared\underline{\hspace{0.3cm}}ptr", (shared_offset - label_offset, shared + label_delta));
label("boost::intruisive\underline{\hspace{0.3cm}}ptr", (intrusive_offset - label_offset, intrusive + label_delta));
label("std::unique\underline{\hspace{0.3cm}}ptr", (unique_offset - label_offset, unique + label_delta));
label("real usecase (decart treee) benchmark : ", (bench_width * 2.0, max_height * 1.1));
