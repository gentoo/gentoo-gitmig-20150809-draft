# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xsu/xsu-0.2.3.ebuild,v 1.13 2005/01/01 11:36:33 eradicator Exp $

DESCRIPTION="Interface for 'su - username -c command' in GNOME."
HOMEPAGE="http://xsu.freax.eu.org/"
SRC_URI="http://xsu.freax.eu.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="=gnome-base/gnome-libs-1.4*
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"
RDEPEND=""

src_compile() {
	# xsu uses its own custom configure script with unflexible Makefiles
	./configure \
		--prefix=/usr \
		--man-base=/usr/share/man \
		--doc-path=/usr/share/doc || die
	make CC="gcc ${CFLAGS}" || die
}

src_install() {
	dobin bin/xsu || die
	doman doc/man/xsu.8
	dodoc AUTHORS CHANGELOG INSTALL README
	dohtml -r doc
}
