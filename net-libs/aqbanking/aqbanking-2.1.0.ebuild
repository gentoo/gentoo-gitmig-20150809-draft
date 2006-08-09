# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-2.1.0.ebuild,v 1.3 2006/08/09 16:46:19 cardoe Exp $

inherit kde-functions

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="chipcard debug dtaus geldkarte hbci kde ofx python qt3 yellownet"
DEPEND=">=sys-libs/gwenhywfar-2.3.0
	>=app-misc/ktoblzcheck-1.10
	ofx? ( >=dev-libs/libofx-0.8 )
	geldkarte? ( >=sys-libs/libchipcard-2.1.6 )
	chipcard? ( >=sys-libs/libchipcard-2.1.6 )"

# gtk2 doesn't build without X, not needed at the moment because no app uses it.
#	gtk? >=dev-util/glade-2"

S=${WORKDIR}/${P}
MAKEOPTS="${MAKEOPTS} -j1"

use qt3 && need-qt 3.1
use kde && need-kde 3.1

src_compile() {
	local FRONTENDS="cbanking"
	(use qt3 || use kde) && FRONTENDS="${FRONTENDS} qbanking"
	use kde && FRONTENDS="${FRONTENDS} kbanking"

#	use gtk && FRONTENDS="${FRONTENDS} g2banking"

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

src_test() {
	einfo Tests disabled for now.
}
