# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="libgcrypt is a general purpose crypto library based on the code used in GnuPG."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/libgcrypt/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org"

DEPEND="virtual/glibc
	app-text/jadetex
	app-text/docbook2X
	nls? ( sys-devel/gettext )"

src_compile() {
	
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	./configure \
		--prefix=/usr	\
		--sysconfdir=/etc	\
		--host=${CHOST}	\
		--enable-m-guard	\
		--enable-static	\
		${myconf} || die
	
	emake  || die
}

src_install () {
	
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING INSTALL NEWS README* THANKS VERSION 
}
