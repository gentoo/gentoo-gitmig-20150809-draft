
# this will hopefully be replaced by a leaner
# sed method later by someone with a clue.
#
open MAKEFILE, "${ARGV[0]}/Makefile";
open TMP, ">${ARGV[0]}/tmp";

while ( <MAKEFILE> ) {
	last if $_ =~ /^PREFIX/;
	print TMP $_;
}

print TMP "PREFIX = ${ARGV[1]}\n";

print TMP while <MAKEFILE>;

close MAKEFILE;
close TMP;

system "cp ${ARGV[0]}/tmp ${ARGV[0]}/Makefile";
unlink "${ARGV[0]}/tmp";
