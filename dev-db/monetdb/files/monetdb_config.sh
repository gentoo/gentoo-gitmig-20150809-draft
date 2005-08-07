#! /bin/sh

MYINCLUDES="-I$_MONETDB_INCLUDEDIR \
			-I$_MONETDB_INCLUDEDIR/common \
			-I$_MONETDB_INCLUDEDIR/gdk \
			-I$_MONETDB_INCLUDEDIR/monet \
			-I$_MONETDB_INCLUDEDIR/plain \
			-I$_MONETDB_INCLUDEDIR/contrib \
			-I$_MONETDB_INCLUDEDIR/mapi \
			-I$_MONETDB_INCLUDEDIR/C"

case $1 in
	--version )	echo $_MONETDB_VERSION; break;;
	--cflags )	echo $MYINCLUDES; break;;
	--includes )	echo $MYINCLUDES; break;;
	--pkgincludedir )	echo $_MONETDB_INCLUDEDIR; break;;
	--libs )	echo $_MONETDB_LIBS; break;;
	--modpath )	echo $_MONETDB_MOD_PATH; break;;
	--prefix )	echo $_MONETDB_PREFIX; break;;
	--classpath )	echo $_MONETDB_CLASSPATH; break;;
esac
