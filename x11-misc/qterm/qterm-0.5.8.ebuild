# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.5.8.ebuild,v 1.1 2009/12/15 14:03:15 matsuu Exp $

EAPI="2"
inherit cmake-utils eutils

DESCRIPTION="A BBS client for Linux"
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.5:4[qt3support]
	dev-libs/openssl"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.7-gentoo.patch
}

src_install() {
	cmake-utils_src_install
	mv "${D}"/usr/bin/qterm "${D}"/usr/bin/QTerm || die
	dodoc README TODO
}

pkg_postinst() {
	einfo
	elog "Since 0.4.0-r1, /usr/bin/qterm has been renamed to /usr/bin/QTerm."
	elog "Please see bug #176533 for more information."
	einfo
}
