# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-0.3.5.ebuild,v 1.7 2004/10/18 15:50:26 lu_zero Exp $

MY_P="SimGear-${PV}"
DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://simgear/Source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=media-libs/plib-1.6.0
	dev-db/metakit
	media-libs/glut"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README* NEWS AUTHORS ChangeLog
}
