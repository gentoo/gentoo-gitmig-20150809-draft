# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.6.1.ebuild,v 1.5 2004/10/31 05:29:35 vapier Exp $

DESCRIPTION="Control a remote computer running VNC from X"
HOMEPAGE="http://fredrik.hubbe.net/x2vnc.html"
SRC_URI="http://fredrik.hubbe.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 sparc x86"
IUSE="tcltk"

DEPEND="virtual/x11
	tcltk? ( dev-tcltk/expect )"

src_install() {
	dodir /usr/share /usr/bin
	make DESTDIR=${D} install || die
	use tcltk && dobin contrib/tkx2vnc
	dodoc ChangeLog README
}
