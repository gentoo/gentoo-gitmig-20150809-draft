# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# Modified Tod M. Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/dev-lang/python/python-2.0-r4.ebuild,v 1.1 2001/06/04 19:49:02 drobbins Exp

S=${WORKDIR}/Python-2.0
S2=${WORKDIR}/python-fchksum-1.1
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/2.0/BeOpen-Python-2.0.tar.bz2 
	 http://www.azstarnet.com/~donut/programs/fchksum/python-fchksum-1.1.tar.gz"

HOMEPAGE="http://www.python.org http://www.azstarnet.com/~donut/programs/fchksum/"

#tcltk depends is = becasue need to automate tcltk version number below
DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )
	tcltk? ( >=dev-lang/tcl-tk-8.0 )"

RDEPEND="$DEPEND"
PROVIDE="virtual/python-2.0"

src_unpack() {
    local mylibs
    unpack BeOpen-Python-2.0.tar.bz2
    cd ${S}/Modules
    if [ "`use readline`" ]
    then
      sed -e 's/#readline/readline/' -e 's/-lreadline -ltermcap/-lreadline/' \
	  -e 's/#_curses _cursesmodule.c -lcurses -ltermcap/_curses _cursesmodule.c -lncurses/' \
	  -e 's/#crypt/crypt/' -e 's/# -lcrypt/-lcrypt/' \
	Setup.in > Setup.new
        mv Setup.new Setup.in
	mylibs="-lreadline -lncurses -lcrypt"
    fi

#Added check for tcltk USE variable, if set build _tkinter
#Need to automate tk and tcl version determination
    if [ "`use tcltk`" ]
    then
      sed -e 's:# _tkinter:_tkinter:' \
          -e 's:#[[:blank:]]*-I/usr/local/include:-I/usr/include:' \
	  -e 's:#[[:blank:]]*-I/usr/X11R6/include:-I/usr/X11R6/include:' \
	  -e 's:#[[:blank:]]*-L/usr/local/lib:-L/usr/lib:' \
	  -e 's:#[[:blank:]]*-ltk8.0 -ltcl8.0:-ltk8.4 -ltcl8.4:' \
	  -e 's:#[[:blank:]]*-L/usr/X11R6/lib:-L/usr/X11R6/lib:' \
	  -e 's:#[[:blank:]]-lX11:-lX11:' \
	Setup.in > Setup.new
        mv Setup.new Setup.in
	mylibs="$mylibs -ltk8.4 -ltcl8.4 -L/usr/X11R6/lib -lX11"
    fi

    if [ "`use berkdb`" ]
    then
      sed -e 's:#dbm.*:dbm dbmmodule.c -I/usr/include/db3 -ldb-3.2:' \
	Setup.in > Setup.new
        mv Setup.new Setup.in
	mylibs="$mylibs -ldb-3.2"
    fi
    
#Removed the commenting out of TKPATH   
    sed	-e 's/#_locale/_locale/'  \
	-e 's/#syslog/syslog/'  \
	-e 's:#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz:zlib zlibmodule.c -lz:' \
	-e 's:^#termios:termios:' -e 's:^#resource:resource:' \
	Setup.in > Setup
	echo "fchksum fchksum.c md5_2.c" >> Setup
        mylibs="-lpython2.0 $mylibs -lz -lutil"
	cd ${S}/Modules

	if [ "`use berkdb`" ]
	then
  	  #patch the dbmmodule to use db3's dbm compatibility code.  That way, we're depending on db3 rather than
	  #old db1.  We'll link with db3, of course.
	  cp dbmmodule.c dbmmodule.c.orig
	  sed -e '10,25d' -e '26i\' -e '#define DB_DBM_HSEARCH 1\' -e 'static char *which_dbm = "BSD db";\' -e '#include <db3/db.h>' dbmmodule.c.orig > dbmmodule.c
	fi

   cp ${FILESDIR}/pfconfig.h .
   unpack python-fchksum-1.1.tar.gz 

   cd python-fchksum-1.1
   mv md5.h ../md5_2.h
   sed -e 's:"md5.h":"md5_2.h":' md5.c > ../md5_2.c
   sed -e 's:"md5.h":"md5_2.h":' fchksum.c > ../fchksum.c

	#for some reason, python 2.0 can't find /usr/lib/python2.0 without this fix to the source code.
	cd ${S}/Python
	cp pythonrun.c pythonrun.c.orig
	sed -e 's:static char \*default_home = NULL:static char \*default_home = "/usr":' pythonrun.c.orig > pythonrun.c

   cat <<END  > ${S}/python-config
#!/bin/sh
echo $mylibs
END

}


src_compile() {   
    cd ${S}
    try ./configure --prefix=/usr --without-libdb
	#libdb3 support is available from http://pybsddb.sourceforge.net/; the one
	#included with python is for db 1.85 only.
    cp Makefile Makefile.orig
    sed -e "s/-g -O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/Modules
    cp Makefile.pre Makefile.orig
    sed -e "s:MODOBJS=:MODOBJS=fchksum.o md5_2.o:" \
    Makefile.orig > Makefile.pre

    # Parallel make does not work
    cd ${S}
    try make 
}

src_install() {                 
    dodir /usr            
    try make install prefix=${D}/usr
	rm ${D}/usr/bin/python
	dosym python2.0 /usr/bin/python
    exeinto /usr/bin
    doexe python-config
    dodoc README

#Change OPT setting in /usr/lib/python2.0/config/Makefile
#to CFLAG from /etc/make.conf so optimaization is set for
#subsequent module installs using distutil.
#There is probably a better way :)
    cd ${D}/usr/lib/python2.0/config
    sed -e "s/OPT=[[:blank:]]*-g -O2 -Wall -Wstrict-prototypes/OPT= ${CFLAGS}/" \    Makefile > Makefile.new
    mv Makefile.new  Makefile

#If USE tcltk lets install idle
#Need to script the python version in the path
    if [ "`use tcltk`" ]
    then
        mkdir ${D}/usr/lib/python2.0/tools
        cd ${S}
        mv Tools/idle ${D}/usr/lib/python2.0/tools/
#don't quit understand dosym; put idle in PATH
         ln -s /usr/lib/python2.0/tools/idle/idle.py ${D}/usr/bin/idle.py
    fi
}

