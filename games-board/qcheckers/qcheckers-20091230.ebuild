# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qcheckers/qcheckers-20091230.ebuild,v 1.1 2009/12/30 20:19:15 ssuominen Exp $

EAPI=2
inherit eutils qt4 games

MY_PN=${PN/qc/QC}

DESCRIPTION="Qt4 based checkers game"
HOMEPAGE="http://code.google.com/p/qcheckers/"
SRC_URI="http://qcheckers.googlecode.com/files/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${MY_PN}

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	dogamesbin ${MY_PN} || die
	newicon icons/help-about.png ${PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN}
	dodoc README
	prepgamesdirs
}
