#!/usr/bin/perl
# interface.c splitter for dc_gui2
# (c) 2003 by Micha³ 'Spock' Januszewski

open(SRC,"<interface.c");
open(EXT,">interface_extern.h");
open(NSRC,">interface_new.c");

$maxlines = 500;

my @temp;
my @objects;

while ($line = <SRC> ) { 

	if ($line =~ /static ([A-Za-z0-9_\ \[\]]+)/) {
		print EXT "extern $1;\n";
		$line =~ s/static//;
	}

	push @temp,$line;
	last if ($line =~ /create_app1 \(void\)/);
}

while ($line = <SRC>) {

	last if ($line =~ /^\s+$/);

	if ($line =~ /(G[A-Za-z0-9]+ \*[A-Za-z0-9_]+)(.*)/) {
		push @objects,"$1$2";
		print EXT "extern $1;\n";
	}
}

$done = 0;

$cnt = 0; 
$linecnt = 0;
$back = $line;

while ($line = <SRC>) {

	last if ($line =~ /return app1/);

	if ($linecnt == 0) {
		open(SPLIT,">interface$cnt.c");

		print SPLIT "#include <sys/types.h>\n#include <sys/stat.h>\n#include <unistd.h>\n#include <string.h>\n#include <stdio.h>\n";
		print SPLIT "#include <gnome.h>\n#include \"callbacks.h\"\n#include \"interface.h\"\n#include \"support.h\"\n#include \"interface_extern.h\"\n";
		print SPLIT "#define GLADE_HOOKUP_OBJECT(component,widget,name) gtk_object_set_data_full (GTK_OBJECT (component), name, gtk_widget_ref (widget), (GtkDestroyNotify) gtk_widget_unref)\n";
		print SPLIT "#define GLADE_HOOKUP_OBJECT_NO_REF(component,widget,name) gtk_object_set_data (GTK_OBJECT (component), name, widget)\n\n";
		print SPLIT "void create_app1_part$cnt (void) {\n\n";
	}

	print SPLIT $line;
	$linecnt++;

	if ($linecnt == $maxlines) {

		# we don't want an unfinished line to be broken between two functions 
		while ($line !~ /;\s*\n$/) { 
			$line = <SRC>;
			print SPLIT $line;
		}
		
		$linecnt = 0;
		print SPLIT "  return;\n}\n";
		close(SPLIT);
		$cnt++;		
	}
}
print SPLIT "  return;\n}\n";
close(SPLIT);

while ($dat = shift @temp) {
	if ($dat =~ /^GtkWidget*/ && !$done) {
		for ($i = 0; $i < $#objects+1; $i++) {
			print NSRC $objects[$i]."\n";
		}	
		print NSRC "\n";
		$done = 1;

		for ($i = 0; $i < $cnt+1; $i++) {
			print NSRC "void create_app1_part$i (void);\n";
		} 

		print NSRC "\n";

	}
	print NSRC $dat
}

print NSRC "{\n";

for ($i = 0; $i < $cnt+1; $i++) {
	print NSRC "  create_app1_part$i ();\n";
} 

print NSRC $line;

while ($line = <SRC>) {
	print NSRC $line;
}


close(SRC);
close(EXT);
close(NSRC);

$cnt++;
$t = "interface.c";

for ($i = 0; $i < $cnt; $i++) {
	$t .= " interface$i.c";	
}

`sed -i 's/interface.c/$t/' Makefile.in`;

$t = 'interface.$(OBJEXT)';

for ($i = 0; $i < $cnt; $i++) {
	$t .= " interface$i.".'$(OBJEXT)';	
}

`sed -i 's/interface.\$\(OBJEXT\)/$t/' Makefile.in`;
`mv -f interface_new.c interface.c`;
