# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.1.1-r4.ebuild,v 1.4 2002/04/30 10:31:08 seemant Exp $

S=${WORKDIR}/Python-${PV}
FCHKSUM="python-fchksum-1.6"
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/${PV}/Python-${PV}.tgz
	http://www.azstarnet.com/~donut/programs/fchksum/${FCHKSUM}.tar.gz"

HOMEPAGE="http://www.python.org http://www.azstarnet.com/~donut/programs/fchksum/"
LICENSE="PSF-2.1.1"

DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )
	tcltk? ( >=dev-lang/tk-8.0 )"

RDEPEND="$DEPEND"
PROVIDE="virtual/python-2.1"

SLOT="2.1"

src_unpack() {
	# unpack python
	unpack Python-${PV}.tgz
	# unpack fchksum and move pieces into Modules subdir
	cd ${S}/Modules
	unpack ${FCHKSUM}.tar.gz
	cd ${FCHKSUM}
	cp md5.h ../md5_2.h
	cp cksum.[ch] sum.[ch] fchksum.h ..
	sed 's:"md5.h":"md5_2.h":' md5.c > ../md5_2.c
	sed 's:"md5.h":"md5_2.h":' fchksum.c > ../fchksum.c
	# add fchksum configuration to Setup
	cd ${S}
	echo "fchksum fchksum.c md5_2.c cksum.c sum.c" >> Modules/Setup.dist

	# adjust makefile to install pydoc into ${D} correctly
	t=${S}/Makefile.pre.in
	cp $t $t.orig || die
	sed 's:install-platlib.*:& --install-scripts=$(BINDIR):' $t.orig > $t
}

src_compile() {
	# python's config seems to ignore CFLAGS
	export OPT=$CFLAGS

	# configure fchksum
	cd ${S}/Modules/${FCHKSUM}
	./configure
	cp pfconfig.h ..

	# adjust Setup to include the various modules we need
	cd ${S}
	scmd=""
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
	
	./configure \
		--prefix=/usr \
		--without-libdb \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man
	assert "Configure failed"
	emake || die "Parallel make failed"
}

src_install() {
	dodir /usr
	make install prefix=${D}/usr || die
	rm "${D}/usr/bin/python"
	dosym python2.1 /usr/bin/python
	dodoc README

	# install our own custom python-config
	exeinto /usr/bin
	doexe ${FILESDIR}/python-config

	# If USE tcltk lets install idle
	# Need to script the python version in the path
	if use tcltk; then
		mkdir "${D}/usr/lib/python2.1/tools"
		mv "${S}/Tools/idle" "${D}/usr/lib/python2.1/tools/"
		dosym /usr/lib/python2.1/tools/idle/idle.py /usr/bin/idle.py
	fi

	# man pages wind up in /usr/man for some reason
	mv ${D}/usr/man ${D}/usr/share
}
