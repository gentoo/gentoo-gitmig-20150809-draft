# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/bigloo-lib/bigloo-lib-0.17.ebuild,v 1.4 2002/07/30 06:59:57 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Bigloo support libraries"
SRC_URI="mirror://sourceforge/bigloo-lib/${P}.tar.gz"
HOMEPAGE="http://bigloo-lib.sf.net"

DEPEND=">=dev-lisp/bigloo-2.4
	gd? ( >=media-libs/libgd-1.8.3 )
	X? ( virtual/x11 )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	ldap? ( >=net-nds/openldap-2.0.18 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	gettext? ( >=sys-devel/gettext-0.11.1 )
	"
#RDEPEND=""

src_compile() {
	local myc
	# readline support is flaky
#	myc="--with-commandline"	
	use gd && myc="$myc --with-gd" || myc="$myc --without-gd"
	use X && myc="$myc --with-x" || myc="$myc --without-x"
	use gtk && myc="$myc --with-gtk" || myc="$myc --without-gtk"
	use gtk2 && myc="$myc --with-gtk2" || myc="$myc --without-gtk2"
	use ldap && myc="$myc --with-ldap" || myc="$myc --without-ldap"
	use nls && myc="$myc --with-iconv" || myc="$myc --without-nls"
	use gettext && myc="$myc --with-gettext" || myc="$myc --without-gettext"
	use ipcs && myc="$myc --with-ipcs" || myc="$myc --without-ipcs"

	# gdbm support doesn't work
#	use gdbm && myc="$myc --with-gdbm" || myc="$myc --without-gdbm"
	myc="$myc --without-gdbm"

	use mysql && myc="$myc --with-mysql" || myc="$myc --without-mysql"
	use postgres && myc="$myc --with-postgres" || myc="$myc --without-postgres"
	use expat && myc="$myc --with-expat" || myc="$myc --without-expat"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myc || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
