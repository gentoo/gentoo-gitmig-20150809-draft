# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-1.6.0_beta.ebuild,v 1.10 2006/08/09 16:46:19 cardoe Exp $

inherit kde-functions

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="debug ofx geldkarte chipcard dtaus hbci kde qt3"
DEPEND=">=sys-libs/gwenhywfar-1.16.0
	app-misc/ktoblzcheck
	ofx? ( >=dev-libs/libofx-0.8 )
	geldkarte? ( >=sys-libs/libchipcard-1.9.15_beta )
	chipcard? ( >=sys-libs/libchipcard-1.9.15_beta )"

# ctypes is not yet keyworded on most archs
#	python? dev-python/ctypes
# gtk2 doesn't build without X, not needed at the moment because no app uses it.
#	gtk? >=dev-util/glade-2"

S=${WORKDIR}/${P/_/}
MAKEOPTS="${MAKEOPTS} -j1"

use qt3 && need-qt 3.1
use kde && need-kde 3.1

src_compile() {
	local FRONTENDS="cbanking"
	use qt3 && FRONTENDS="${FRONTENDS} qbanking"
	use kde && FRONTENDS="${FRONTENDS} kbanking"

#	use gtk && FRONTENDS="${FRONTENDS} g2banking"

	local BACKENDS=""
	use hbci && BACKENDS="aqhbci"
	use geldkarte && BACKENDS="${BACKENDS} aqgeldkarte"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"
	use dtaus && BACKENDS="${BACKENDS} aqdtaus"

	econf $(use_enable debug) \
		$(use_enable kde kde3) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README COPYING doc/*
}
