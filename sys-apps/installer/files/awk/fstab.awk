BEGIN { 

	print "# /etc/fstab: static filesystem information"
	print "#"
	print "# <fs>\t\t<mountpoint>\t<type>\t\t<options>\t<dump/pass>"

}

$1 =="(point", $1 ==")point" { if ( $1 !~ /.point/ ) p=$1 }
$1 =="(device", $1==")device" { if ( $1 !~ /.device/ ) d=$1 }
$1 =="(options", $1==")options" { if ( $1 !~ /.options/ ) o=$1 }
$1 =="(type", $1==")type" { if ( $1 !~ /.type/ ) t=$1 }
$1 =="(dump", $1==")dump" { if ( $1 !~ /.dump/ ) du=$1 }
$1 =="(pass", $1==")pass" { if ( $1 !~ /.pass/ ) pa=$1 }

/\)mount/ { 

	if ( length(d)<8 ) d=(d "\t")
	if ( length(p)<8 ) p=(p "\t")
	if ( length(t)<8 ) t=(t "\t")
	if ( o=="" ) o="default"
	if ( length(o)<8 ) o=(o "\t")
	if ( du=="" ) du=0
	if ( pa=="" ) pa=0

	print d "\t" p "\t" t "\t" o "\t" du " " pa 

	t=""; du=""; pa=""; p=""; d=""; o="";
}