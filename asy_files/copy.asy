settings.outformat = "pdf";

real linked = 49;
real shared = 75;
real intrusive = 55;
real unique = 0;
real bench_width = 44.0;
real max_height = 75;

real linked_offset = bench_width;
real shared_offset = 2 * bench_width;
real intrusive_offset = 3 * bench_width;
real unique_offset = 4 * bench_width;
real label_offset = (shared_offset - linked_offset) / 2.0;

size(20cm,0);
path lin = box((0,0), (linked_offset,linked));
fill(lin, green);

path sha = box((linked_offset,0), (shared_offset,shared));
fill(sha, blue);

path intr = box((shared_offset,0), (intrusive_offset,intrusive));
fill(intr, magenta);

path uniq = box((intrusive_offset,0), (unique_offset,unique));
fill(uniq, red);
label("$linked\underline{\hspace{0.3cm}}ptr$", (linked_offset - label_offset, linked * 1.03), black);
label("$std::shared\underline{\hspace{0.3cm}}ptr$", (shared_offset - label_offset, shared * 1.03), black);
label("$boost::intruisive\underline{\hspace{0.3cm}}ptr$", (intrusive_offset - label_offset, intrusive * 1.03), black);
label("$std::unique\underline{\hspace{0.3cm}}ptr$", (unique_offset - label_offset, unique * 1.03), black);
label("copy constructor benchmark : ", (bench_width * 2.0, max_height * 1.1));
