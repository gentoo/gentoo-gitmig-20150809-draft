# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icesndcfg/icesndcfg-1.1.ebuild,v 1.6 2004/04/26 14:50:17 agriffis Exp $

IUSE=""

DESCRIPTION="IceWM sound editor."
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"

DEPEND="virtual/x11
	>=x11-libs/qt-3.0.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile () {
	addwrite ${QTDIR}/etc/settings
	econf || die "econf failed"
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING TODO README
}
