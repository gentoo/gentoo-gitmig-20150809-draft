# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcut/xcut-0.2.ebuild,v 1.2 2005/03/28 21:37:47 agriffis Exp $

inherit eutils

IUSE=""
DESCRIPTION="Commandline tool to manipulate the X11 cut and paste buffers"
HOMEPAGE="http://xcut.sourceforge.net"
SRC_URI="mirror://sourceforge/xcut/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	make DESTDIR=${D} install.man || die "make install.man failed"
	dodoc README || die "dodoc failed"
}
