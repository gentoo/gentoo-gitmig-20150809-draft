# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-1.0.9.ebuild,v 1.3 2001/11/10 12:45:09 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GOB is a preprocessor for making GTK+ objects with inline C code"
SRC_URI="http://ftp.5z.com/pub/gob/${P}.tar.gz"
HOMEPAGE="http://www.5z.com/jirka/gob.html"

RDEPEND=">=dev-libs/glib-1.2.10"

DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man 
	assert

	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
