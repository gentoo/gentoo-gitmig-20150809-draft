# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/plcedit/plcedit-2.2.0.ebuild,v 1.2 2010/10/08 11:17:01 hwoarang Exp $

EAPI="2"

inherit versionator qt4-r2
MY_PN="PLCEdit"

DESCRIPTION="Qt4 notepad for PLC programming"
HOMEPAGE="http://www.qt-apps.org/content/show.php/PLCEdit?content=78380"
#upstreams default tarball is quite messy. Better repack it myself :/
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc"

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	if use doc; then
	sed -i -e "/helpDir =/s:Help:html:" \
		-e "s:(QApplication\:\:applicationDirPath():\"/usr/share/doc/${PF}\":g" \
		-e "/ + helpDir/s:helpDir):helpDir:" \
		src/helpwidget.cpp
	fi
	qt4-r2_src_prepare
}

src_install() {
	newbin release/${MY_PN} ${PN} || die "dobin failed"
	newicon src/ressources/images/icon.png ${PN}.png
	make_desktop_entry ${PN} ${MY_PN} ${PN} 'Qt;Electronics'
	dodoc readme.txt || die "dodoc failed"
	if use doc; then
		dohtml -r Docs/html/* || die "dohtml failed"
	fi
}
