# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tuxcards/tuxcards-1.2.ebuild,v 1.10 2005/06/16 15:11:34 ticho Exp $

inherit kde-functions

DESCRIPTION="A heirarchical text editor"
HOMEPAGE="http://www.tuxcards.de"

SRC_URI="http://www.tifskom.de/tux/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ppc x86"
IUSE=""
DEPEND="${DEPEND}
		=x11-libs/qt-3*
		sys-apps/sed"

# This implies >=qt-3, thus qt4 as well - we don't build with qt4 (bug #96201)
#need-qt 3.1

src_compile() {
	sed -i -e 's:/usr/local:/usr:g' \
		-e 's:/usr/doc/tuxcards:/usr/share/tuxcards:g' tuxcards.pro
	sed -i -e 's:/usr/local/doc:/usr/share:g' src/CTuxCardsConfiguration.cpp
	sed -i -e 's:/usr/local/bin/:/usr/bin/:g' \
		src/gui/dialogs/optionsDialog/IOptionsDialog.ui

	# Use qt3's qmake (bug #96201)
	/usr/qt/3/bin/qmake tuxcards.pro

	emake || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
	dodoc AUTHORS COPYING INSTALL README
}
