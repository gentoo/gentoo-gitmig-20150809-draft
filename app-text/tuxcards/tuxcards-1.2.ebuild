# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tuxcards/tuxcards-1.2.ebuild,v 1.7 2005/02/02 18:05:59 luckyduck Exp $

inherit kde-functions

DESCRIPTION="A heirarchical text editor"
HOMEPAGE="http://www.tuxcards.de"

SRC_URI="http://www.tifskom.de/tux/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND="sys-apps/sed"

need-qt 3.1

src_compile() {
	sed -e 's:/usr/local:/usr:g' \
		-e 's:/usr/doc/tuxcards:/usr/share/tuxcards:g' tuxcards.pro > tuxpro && \
		mv tuxpro tuxcards.pro
	sed -e 's:/usr/local/doc:/usr/share:g' src/CTuxCardsConfiguration.cpp > temp && \
		mv temp src/CTuxCardsConfiguration.cpp
	sed -e 's:/usr/local/bin/:/usr/bin/:g' src/gui/dialogs/optionsDialog/IOptionsDialog.ui > temp && \
		mv temp src/gui/dialogs/optionsDialog/IOptionsDialog.ui

	qmake tuxcards.pro

	emake || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
	dodoc AUTHORS COPYING INSTALL README
}
