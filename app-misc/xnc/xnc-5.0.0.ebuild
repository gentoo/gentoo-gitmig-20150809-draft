# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xnc/xnc-5.0.0.ebuild,v 1.1 2003/01/08 21:33:21 bass Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A ile manager for X Window system very similar to Norton Commander, with a lot of features."
SRC_URI="http://xnc.dubna.su/src-5/${P}.src.tar.gz"
HOMEPAGE="http://xnc.dubna.su/"
LICENSE="GPL-2"
DEPEND="x11-base/xfree"

KEYWORDS="x86"
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO
}
