# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neotools/neotools-0.8.1.ebuild,v 1.5 2004/08/13 08:44:03 mr_bones_ Exp $

DESCRIPTION="Various development tools for NeoEngine"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/neoengine-${PV}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-games/neoengine-${PV}
	>=sys-apps/sed-4"

S="${WORKDIR}/neoengine-${PV}/neotools"

src_unpack() {
	local i

	unpack ${A}

	cd "${S}"
	sed -i \
		-e 's/BUILD_STATIC/BUILD_DYNAMIC/g' configure \
		|| die "sed configure failed"
	for i in `find "${S}" -name Makefile.in`; do
		sed -i \
			-e 's/BUILD_STATIC/BUILD_DYNAMIC/g' \
			-e 's/_static//g' \
			${i} \
			|| die "sed ${i} failed"
	done
}

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
