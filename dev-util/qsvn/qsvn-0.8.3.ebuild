# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qsvn/qsvn-0.8.3.ebuild,v 1.2 2009/12/12 14:40:35 ayoy Exp $

EAPI="2"

inherit cmake-utils eutils

DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://www.anrichter.net/projects/qsvn/"
SRC_URI="http://www.anrichter.net/projects/${PN}/chrome/site/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4[qt3support]
	x11-libs/qt-sql:4[sqlite]
	dev-util/subversion"
DEPEND="${RDEPEND}
	x11-libs/qt-test"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}/${P}-tests.patch"
}

src_install() {
	cmake-utils_src_install
	dodoc ../{ChangeLog,README} || die
}
