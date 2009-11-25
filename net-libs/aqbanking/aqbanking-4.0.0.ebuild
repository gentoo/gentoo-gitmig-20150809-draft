# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-4.0.0.ebuild,v 1.8 2009/11/25 17:10:14 ssuominen Exp $

EAPI="2"

inherit eutils qt3

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=03&release=36&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE="chipcard debug ofx python qt3"

DEPEND=">=sys-libs/gwenhywfar-3.8.1
	>=app-misc/ktoblzcheck-1.14
	ofx? ( >=dev-libs/libofx-0.8.3 )
	chipcard? ( >=sys-libs/libchipcard-4.2.8 )
	qt3? ( =x11-libs/qt-3* )"

MAKEOPTS="${MAKEOPTS} -j1"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.diff
}

src_configure() {
	local FRONTENDS="cbanking"
	use qt3 && FRONTENDS="${FRONTENDS} qbanking"

	local BACKENDS="aqhbci"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"

	econf PATH="/usr/qt/3/bin:${PATH}" \
		$(use_enable debug) \
		$(use_enable python) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" \
		--with-docpath="/usr/share/doc/${PF}/apidoc"|| die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rm -rf "${D}/usr/share/doc"
	dodoc AUTHORS README doc/* || die "dodoc failed"
	find "${D}" -name '*.la' -delete
}
