# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neotools/neotools-0.7.0.ebuild,v 1.4 2004/06/29 19:12:04 agriffis Exp $

DESCRIPTION="Various development tools for NeoEngine"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-games/neoengine-0.7.0
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's/BUILD_STATIC/BUILD_DYNAMIC/g' configure
	for i in `find ${S} -name 'Makefile.in'`; do
		sed -i -e 's/BUILD_STATIC/BUILD_DYNAMIC/g' ${i};
		sed -i -e 's/_static//g' ${i};
	done
}

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
