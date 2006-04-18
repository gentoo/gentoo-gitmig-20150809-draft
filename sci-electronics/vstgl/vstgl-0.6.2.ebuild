# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/vstgl/vstgl-0.6.2.ebuild,v 1.4 2006/04/18 02:13:28 markusle Exp $

inherit eutils qt3

IUSE=""

DESCRIPTION="Visual Signal Transition Graph Lab"
HOMEPAGE="http://vstgl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="$(qt_min_version 3.3.4)
	media-libs/libpng
	sys-libs/zlib
	sci-electronics/petrify"

S="${WORKDIR}/${PN}"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	sed -e "s:^qmake:${QTDIR}\/bin\/qmake:" -i configure
}

src_install () {
	einstall INSTALL_ROOT=${D} || die
	dodoc README
	dodir /usr/share/doc/${P}/
	cp -pPR examples ${D}/usr/share/doc/${P}/
}
