# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-0.3.4.ebuild,v 1.4 2004/06/24 22:14:21 agriffis Exp $

MY_P=SimGear-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://simgear/Source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=media-libs/plib-1.6.0
	dev-db/metakit
	media-libs/glut"

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc README* NEWS AUTHORS ChangeLog
}
