# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neotools/neotools-0.8.0.ebuild,v 1.1 2004/03/23 21:36:36 dholm Exp $

S="${WORKDIR}/neoengine-${PV}/neotools"
DESCRIPTION="Various development tools for NeoEngine"
SRC_URI="mirror://sourceforge/neoengine/neoengine-${PV}.tar.bz2"
HOMEPAGE="http://www.neoengine.org/"
LICENSE="MPL-1.1"
DEPEND=">=dev-games/neoengine-0.8.0"
KEYWORDS="~ppc ~x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's/BUILD_STATIC/BUILD_DYNAMIC/g' configure
	for i in `find ${S} -name 'Makefile.in'`; do
		sed -i -e 's/BUILD_STATIC/BUILD_DYNAMIC/g' ${i};
		sed -i -e 's/_static//g' ${i};
	done
}

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO
}
