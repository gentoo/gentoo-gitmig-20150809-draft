# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-1.9.9_beta.ebuild,v 1.1 2006/03/22 16:23:11 hanno Exp $

inherit kde-functions

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="debug ofx geldkarte chipcard dtaus hbci kde qt"
DEPEND=">=sys-libs/gwenhywfar-2.1.0
	>=app-misc/ktoblzcheck-1.9
	ofx? ( >=dev-libs/libofx-0.8 )
	geldkarte? ( >=sys-libs/libchipcard-2.1.2 )
	chipcard? ( >=sys-libs/libchipcard-2.1.2 )"

# ctypes is not yet keyworded on most archs
#	python? dev-python/ctypes
# gtk2 doesn't build without X, not needed at the moment because no app uses it.
#	gtk2? >=dev-util/glade-2"

S=${WORKDIR}/${P/_/}
MAKEOPTS="${MAKEOPTS} -j1"

use qt && need-qt 3.1
use kde && need-kde 3.1

src_compile() {
	local FRONTENDS="cbanking"
	(use qt || use kde) && FRONTENDS="${FRONTENDS} qbanking"
	use kde && FRONTENDS="${FRONTENDS} kbanking"

#	use gtk2 && FRONTENDS="${FRONTENDS} g2banking"

	local BACKENDS=""
	use hbci && BACKENDS="aqhbci"
	use geldkarte && BACKENDS="${BACKENDS} aqgeldkarte"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"
	use dtaus && BACKENDS="${BACKENDS} aqdtaus"

	econf PATH="/usr/qt/3/bin:${PATH}" \
		$(use_enable debug) \
		$(use_enable kde kde3) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README COPYING doc/*
}
