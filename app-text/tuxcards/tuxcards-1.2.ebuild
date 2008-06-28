# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tuxcards/tuxcards-1.2.ebuild,v 1.18 2008/06/28 15:44:25 loki_val Exp $

inherit base qt3

DESCRIPTION="A hierarchical text editor"
HOMEPAGE="http://www.tuxcards.de"

SRC_URI="http://www.tifskom.de/tux/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ppc sparc x86"
IUSE=""
DEPEND="=x11-libs/qt-3*
	sys-apps/sed"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	sed -i -e 's:/usr/local:/usr:g' \
		-e 's:/usr/doc/tuxcards:/usr/share/tuxcards:g' tuxcards.pro
	sed -i -e 's:/usr/local/doc:/usr/share:g' src/CTuxCardsConfiguration.cpp
	sed -i -e 's:/usr/local/bin/:/usr/bin/:g' \
		src/gui/dialogs/optionsDialog/IOptionsDialog.ui

	# bug #132393
	sed -i -e 's/<includehint>ccolorbar.h<\/includehint>//' \
		src/gui/dialogs/optionsDialog/IOptionsDialog.ui

	# Use qt3's qmake (bug #96201)
	/usr/qt/3/bin/qmake tuxcards.pro

	# Remove the strip command from Makefile, let portage strip if it wants to.
	# (bug #152264)
	sed -i -e 's/	-strip.*//' Makefile

	emake || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
	dodoc AUTHORS README
}
