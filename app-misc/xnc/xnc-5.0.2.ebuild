# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Licensev2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xnc/xnc-5.0.2.ebuild,v 1.2 2003/08/05 18:26:44 vapier Exp $

DESCRIPTION="file manager for X Window system very similar to Norton Commander"
HOMEPAGE="http://xnc.dubna.su/"
SRC_URI="http://xnc.dubna.su/src-5/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="x11-base/xfree"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable nls` \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO
}
