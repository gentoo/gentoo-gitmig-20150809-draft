# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xsu/xsu-0.2.3.ebuild,v 1.1 2002/07/14 19:46:43 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Interface for 'su - username -c command' in GNOME."
SRC_URI="http://xsu.freax.eu.org/files/${P}.tar.gz"
HOMEPAGE="http://xsu.freax.eu.org"
SLOT="0"
KEYWORDS="*"
DEPEND="=gnome-base/gnome-libs-1.4* 
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*"

src_compile() {

	# xsu uses its own custom configure script with unflexible Makefiles
	./configure --prefix=/usr -man-base=/usr/share/man --doc-path=/usr/share/doc || die

	make CC="gcc ${CFLAGS}" || die

}

src_install() {
	dobin bin/xsu
	doman doc/man/xsu.8
	dodoc AUTHORS CHANGELOG COPYING INSTALL README
	dohtml doc/html/xsu_doc.html doc/html/xsu_example.jpg \
		doc/html/xsu_example2.png doc/html/xsu_example3.png \
		doc/html/xsu_in_gmenu.jpg
}

