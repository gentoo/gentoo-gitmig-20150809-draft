# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.0.7-r1.ebuild,v 1.1 2001/11/16 12:39:21 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxslt"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND="virtual/glibc
	>=dev-libs/libxml2-2.4.10"

DEPEND="${RDEPEND}
	sys-devel/perl"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man || die

	make || die
}

src_install() {                               
        make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	mv ${D}/usr/doc/${P}/html ${D}/usr/share/doc/${PF}/
	rm -rf ${D}/usr/doc
}
