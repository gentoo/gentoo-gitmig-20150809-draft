# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.8.1.ebuild,v 1.1 2004/01/21 08:56:48 torbenh Exp $


DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${P}"

DEPEND="virtual/x11
	>=x11-libs/qt-3"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}
