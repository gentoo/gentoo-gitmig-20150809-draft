# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tn5250/tn5250-0.16.5.ebuild,v 1.4 2003/09/05 22:01:49 msterret Exp $

DESCRIPTION="Telnet client for the IBM AS/400 that emulates 5250 terminals and printers."
HOMEPAGE="http://tn5250.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

IUSE="X ssl slang"

DEPEND="sys-libs/ncurses
	X? ( virtual/x11 )
	ssl? ( dev-libs/openssl )
	slang? ( sys-libs/slang )"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}

	# First, for some reason, TRUE and FALSE aren't defined
	# for the compile.  This causes some problems.  ???
	echo                               >> ${S}/src/tn5250-config.h.in
	echo "/* Define TRUE and FALSE */" >> ${S}/src/tn5250-config.h.in
	echo "#define FALSE 0"             >> ${S}/src/tn5250-config.h.in
	echo "#define TRUE !FALSE"         >> ${S}/src/tn5250-config.h.in

	# Next, the Makefile for the terminfo settings tries to remove
	# some files it doesn't have access to.  We can just remove those
	# lines.
	cd ${S}/linux
	cp Makefile.in Makefile.in.orig
	sed -e "/rm -f \/usr\/.*\/terminfo.*5250/d" \
	    Makefile.in.orig > Makefile.in
}

src_compile() {
	local myconf
	myconf=""
	use X && myconf="${myconf} --with-x"
	use ssl && myconf="${myconf} --with-ssl"
	use slang && myconf="${myconf} --with-slang"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {

	# The TERMINFO variable needs to be defined for the install
	# to work, because the install calls "tic."  man tic for
	# details.
	mkdir -p ${D}/usr/share/terminfo
	make DESTDIR=${D} \
	     TERMINFO=${D}/usr/share/terminfo install || die
	dodoc AUTHORS BUGS COPYING INSTALL NEWS README README.ssl TODO
	dohtml -r doc/*
}
