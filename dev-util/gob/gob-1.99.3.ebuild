# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-1.99.3.ebuild,v 1.1 2002/05/28 22:56:48 spider Exp $


MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GOB is a preprocessor for making GTK+ objects with inline C code"
SRC_URI="http://ftp.5z.com/pub/gob/${MY_P}.tar.gz"
HOMEPAGE="http://www.5z.com/jirka/gob.html"

RDEPEND="=dev-libs/glib-2.0*
	dev-libs/popt"

DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man  || die "configure fail"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING COPYING.generated-code ChangeLog NEWS README TODO
}
