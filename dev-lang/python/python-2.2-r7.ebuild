# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.2-r7.ebuild,v 1.3 2002/07/21 00:59:19 cardoe Exp $

PYVER_MAJOR="`echo ${PV} | cut -d '.' -f 1`"
PYVER_MINOR="`echo ${PV} | cut -d '.' -f 2`"
PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
S=${WORKDIR}/Python-${PV}
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PV}/Python-${PV}.tgz"

HOMEPAGE="http://www.python.org"
LICENSE="PSF-2.2"
KEYWORDS="x86"

DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )
	tcltk? ( >=dev-lang/tk-8.0 )"
RDEPEND="$DEPEND dev-python/python-fchksum"

# The dev-python/python-fchksum RDEPEND is needed to that this python provides
# the functionality expected from previous pythons.

PROVIDE="virtual/python"

SLOT="2.2"

src_compile() {
	# python's config seems to ignore CFLAGS
	export OPT=$CFLAGS 

	# adjust makefile to install pydoc into ${D} correctly
	t=${S}/Makefile.pre.in
	cp $t $t.orig || die
	sed 's:install-platlib.*:& --install-scripts=$(BINDIR):' $t.orig > $t
        
	# adjust Setup to include the various modules we need
	cd ${S}
        # turn **on** shared
	scmd="s:#\(\*shared\*\):\1:;"
	# adjust for USE readline
	if use readline; then
		scmd="$scmd  s:#\(readline .*\) -ltermcap:\1:;"
		scmd="$scmd  s:#\(_curses .*\) -lcurses -ltermcap:\1 -lncurses:;"
	fi
	# adjust for USE tcltk
	if use tcltk; then
		# Find the version of tcl/tk that has headers installed.
		# This will be the most recently merged, not necessarily the highest
		# version number.
		tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
		tkv=$( grep  TK_VER /usr/include/tk.h  | sed 's/^.*"\(.*\)".*/\1/')
		# adjust Setup to match
		scmd="$scmd  s:# \(_tkinter \):\1:;"
		scmd="$scmd  s:#\(\t-ltk[0-9.]* -ltcl[0-9.]*\):\t-ltk$tkv -ltcl$tclv:;"
		scmd="$scmd  s:#\(\t-L/usr/X11R6/lib\):\1:;"
		scmd="$scmd  s:#\(\t-lX11.*\):\1:;"
		scmd="$scmd  s:#\(\t-I/usr/X11R6/include\):\1:;"
	fi
	# adjust for USE berkdb
	if use berkdb; then
		# patch the dbmmodule to use db3's dbm compatibility code.  That way,
		# we're depending on db3 rather than old db1.
		t=Modules/dbmmodule.c
		cp $t $t.orig || die
		sed \
			-e '10,25d' \
			-e '26i\' \
			-e '#define DB_DBM_HSEARCH 1\' \
			-e 'static char *which_dbm = "BSD db";\' \
			-e '#include <db3/db.h>' \
			$t.orig > $t
		# now fix Setup
		scmd="$scmd  s:#dbm.*:dbm dbmmodule.c -I/usr/include/db3 -ldb-3.2:;"
	fi
	# no USE vars to switch off these adjustments:
	scmd="$scmd  s:#\(_locale .*\):\1:;"  # access to ISO C locale support
	scmd="$scmd  s:#\(syslog .*\):\1:;"   # syslog daemon interface
	scmd="$scmd  s:#\(zlib .*\):\1:;"     # This require zlib 1.1.3 (or later).
	scmd="$scmd  s:#\(termios .*\):\1:;"  # Steen Lumholt's termios module
	scmd="$scmd  s:#\(resource .*\):\1:;" # Jeremy Hylton's rlimit interface
	sed "$scmd" Modules/Setup.dist > Modules/Setup
       
	local myopts
	#if we are creating a new build image, we remove the dependency on g++
	if [ "`use build`" -a ! "`use bootstrap`" ]
	then
		myopts="--with-cxx=no"
	fi
	./configure \
		--prefix=/usr \
		--without-libdb \
		--infodir='${prefix}'/share/info \
		--mandir='${prefix}'/share/man $myopts
	assert "Configure failed"
	# kill the -DHAVE_CONFIG_H flag
	mv Makefile Makefile.orig
	sed -e 's/-DHAVE_CONFIG_H//' Makefile.orig > Makefile
	#emake || die "Parallel make failed"
	make || die "Parallel make failed"
}

src_install() {
	dodir /usr
	make install prefix=${D}/usr || die
	rm "${D}/usr/bin/python"	
	dosym python${PYVER_MAJOR} /usr/bin/python
	dosym python${PYVER_MAJOR}.${PYVER_MINOR} /usr/bin/python${PYVER_MAJOR}
	dodoc README

	# install our own custom python-config
	exeinto /usr/bin
	newexe ${FILESDIR}/python-config-${PYVER} python-config

	# seems like the build do not install Makefile.pre.in anymore
	insinto /usr/lib/python${PYVER}/config
	doins ${S}/Makefile.pre.in

	# If USE tcltk lets install idle
	# Need to script the python version in the path
	if use tcltk; then
		mkdir "${D}/usr/lib/python${PYVER}/tools"
		mv "${S}/Tools/idle" "${D}/usr/lib/python${PYVER}/tools/"
		dosym /usr/lib/python${PYVER}/tools/idle/idle.py /usr/bin/idle.py
	fi
}
