# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/kpsk/kpsk-1.0.1.ebuild,v 1.4 2004/07/14 20:45:44 agriffis Exp $

DESCRIPTION="KPSK is a PSK31 digital radio communications application for use by licensed amateur radio operators"
HOMEPAGE="http://kpsk.sourceforge.net/"
SRC_URI="mirror://sourceforge/kpsk/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/qt-3.0.3
	>=kde-base/kdelibs-3.0.1
	>=sys-libs/db-3.1
	sys-libs/zlib
	media-libs/libpng"
RDEPEND=""

src_compile() {
	addwrite $QTDIR/etc/settings
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
