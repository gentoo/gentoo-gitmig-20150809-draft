# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/valknut/valknut-0.3.3.ebuild,v 1.5 2004/11/11 22:40:30 kloeri Exp $

inherit kde

DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dcgui.berlios.de/"
SRC_URI="http://download.berlios.de/dcgui/valknut-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha hppa ~amd64 ~ia64"
IUSE="ssl"

DEPEND=">=dev-libs/libxml2-2.4.22
	~net-p2p/dclib-${PV}
	ssl? ( dev-libs/openssl )
	>=x11-libs/qt-3"

src_compile() {
	addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	econf \
		`use_with ssl` \
		--with-libdc=/usr \
		--with-qt-dir=/usr/qt/3 \
		|| die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
