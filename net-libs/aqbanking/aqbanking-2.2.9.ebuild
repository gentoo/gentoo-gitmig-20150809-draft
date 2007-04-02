# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-2.2.9.ebuild,v 1.1 2007/04/02 23:19:22 hanno Exp $

inherit kde-functions

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="chipcard debug dtaus geldkarte hbci kde ofx python qt3 yellownet"
DEPEND=">=sys-libs/gwenhywfar-2.5.4
	>=app-misc/ktoblzcheck-1.13
	ofx? ( >=dev-libs/libofx-0.8.3 )
	geldkarte? ( >=sys-libs/libchipcard-3.0.2 )
	chipcard? ( >=sys-libs/libchipcard-3.0.2 )
	qt3? ( =x11-libs/qt-3* )
	kde? ( >=kde-base/kdelibs-3.1.0 )"

S=${WORKDIR}/${P}
MAKEOPTS="${MAKEOPTS} -j1"
RESTRICT="test"

src_compile() {
	set-kdedir

	local FRONTENDS="cbanking"
	(use qt3 || use kde) && FRONTENDS="${FRONTENDS} qbanking"
	use kde && FRONTENDS="${FRONTENDS} kbanking"

	local BACKENDS=""
	use hbci && BACKENDS="aqhbci"
	use geldkarte && BACKENDS="${BACKENDS} aqgeldkarte"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"
	use dtaus && BACKENDS="${BACKENDS} aqdtaus"
	use yellownet && BACKENDS="${BACKENDS} aqyellownet"

	econf PATH="/usr/qt/3/bin:${PATH}" \
		$(use_enable debug) \
		$(use_enable kde kde3) \
		$(use_enable python) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" \
		--with-docpath=/usr/share/doc/${PF}/apidoc|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README doc/*
}
