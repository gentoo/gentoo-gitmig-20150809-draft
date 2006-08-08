# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/valknut/valknut-0.3.7.ebuild,v 1.10 2006/08/08 22:47:17 wolf31o2 Exp $

inherit kde-functions eutils

DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://dcgui.berlios.de/"
SRC_URI="http://download.berlios.de/dcgui/valknut-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 x86"
IUSE="ssl"

DEPEND=">=dev-libs/libxml2-2.4.22
	~net-p2p/dclib-${PV}
	ssl? ( dev-libs/openssl )"

need-qt 3

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf \
		`use_with ssl` \
		--with-libdc=/usr \
		--with-qt-dir=${QTDIR} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
