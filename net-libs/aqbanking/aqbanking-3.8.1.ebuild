# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-3.8.1.ebuild,v 1.2 2008/12/01 00:41:55 hanno Exp $

inherit kde-functions

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://files.hboeck.de/aq/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="chipcard debug hbci kde ofx python qt3"
DEPEND=">=sys-libs/gwenhywfar-3.4.1
	>=app-misc/ktoblzcheck-1.14
	ofx? ( >=dev-libs/libofx-0.8.3 )
	chipcard? ( >=sys-libs/libchipcard-4.2.0 )
	qt3? ( =x11-libs/qt-3* )
	kde? ( >=kde-base/kdelibs-3.1.0 )"

MAKEOPTS="${MAKEOPTS} -j1"
RESTRICT="test"

src_compile() {
	set-kdedir

	local FRONTENDS="cbanking"
	(use qt3 || use kde) && FRONTENDS="${FRONTENDS} qbanking"
	use kde && FRONTENDS="${FRONTENDS} kbanking"

	local BACKENDS=""
	use hbci && BACKENDS="aqhbci"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"

	econf PATH="/usr/qt/3/bin:${PATH}" \
		$(use_enable debug) \
		$(use_enable kde kde3) \
		$(use_enable python) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" \
		--with-docpath="/usr/share/doc/${PF}/apidoc"|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rm -rf "${D}/usr/share/doc"
	dodoc AUTHORS README doc/* || die "dodoc failed"
	find "${D}" -name '*.la' -delete
}
