# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fracplanet/fracplanet-0.4.0.ebuild,v 1.1 2009/12/17 18:59:35 ssuominen Exp $

EAPI=2
inherit qt4

DESCRIPTION="Fractal planet and terrain generator"
HOMEPAGE="http://sourceforge.net/projects/fracplanet/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	dev-libs/boost"
DEPEND="${RDEPEND}
	dev-libs/libxslt"

S=${WORKDIR}/${PN}

src_configure() {
	eqmake4
}

src_compile() {
	xsltproc -stringparam version ${PV} -html htm_to_qml.xsl fracplanet.htm \
		| sed 's/"/\\"/g' | sed 's/^/"/g' | sed 's/$/\\n"/g'> usage_text.h
	emake || die
}

src_install() {
	dobin ${PN} || die
	dodoc BUGS NEWS README THANKS TODO
	dohtml *.{css,htm}
}
