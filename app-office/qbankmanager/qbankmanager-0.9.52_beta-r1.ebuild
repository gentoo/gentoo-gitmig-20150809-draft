# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qbankmanager/qbankmanager-0.9.52_beta-r1.ebuild,v 1.6 2010/11/12 10:10:40 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="Onlinebanking frontend for aqbanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=04&release=05&file=01&dummy=${P/_/}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="debug"

RDEPEND=">=net-libs/aqbanking-4.2.0[qt4]
	=net-libs/aqbanking-4*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_/}

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	local qt3_libs qt3_includes

	qt3_libs="$(pkg-config QtCore QtGui Qt3Support --libs)"
	qt3_includes="$(pkg-config QtCore QtGui Qt3Support --cflags-only-I)"

	econf \
		QTDIR="/usr/$(get_libdir)/qt4" \
		QT3TO4="/usr/bin/qt3to4" \
		qt3_libs="${qt3_libs}" \
		qt3_includes="${qt3_includes}" \
		--disable-dependency-tracking \
		$(use_enable debug)

	emake qt4-port
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
