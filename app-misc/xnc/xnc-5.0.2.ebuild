# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xnc/xnc-5.0.2.ebuild,v 1.1 2003/03/26 05:18:42 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ile manager for X Window system very similar to Norton Commander, with a lot of features."
HOMEPAGE="http://xnc.dubna.su/"
SRC_URI="http://xnc.dubna.su/src-5/${P}.src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="x11-base/xfree"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable nls` || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO
}
