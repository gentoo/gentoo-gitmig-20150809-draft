# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.6.ebuild,v 1.10 2004/07/15 00:56:41 agriffis Exp $

DESCRIPTION="Control a remote computer running VNC from X"
SRC_URI="http://fredrik.hubbe.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://fredrik.hubbe.net/x2vnc.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc amd64"

DEPEND="virtual/x11
	tcltk? ( dev-tcltk/expect )"

IUSE="tcltk"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install () {

	dodir /usr/share
	dodir /usr/bin
	make DESTDIR=${D} install || die

	if use tcltk
	then
		dobin contrib/tkx2vnc
	fi

	dodoc ChangeLog README
}
