# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-1.12.7.ebuild,v 1.2 2011/11/21 08:46:32 radhermit Exp $

EAPI=2
inherit eutils qt4-r2

DESCRIPTION="View Your Mind, a mindmap tool"
HOMEPAGE="http://www.insilmaril.de/vym/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4[qt3support]
	x11-libs/qt-sql:4[qt3support]"
RDEPEND="${DEPEND}
	app-arch/zip
	x11-libs/libX11
	x11-libs/libXext"

src_prepare() {
	qt4-r2_src_prepare

	# Change installation directory and demo path
	sed -i \
		-e "s@/usr/local@/usr@g" \
		-e "s@doc/packages/vym@doc/${PF}@g" \
		vym.pro || die "sed failed"
}

src_install() {
	# Remove stripping stuff
	sed -i "/-strip/d" Makefile || die "sed failed"

	DOCS="README.txt"
	qt4-r2_src_install

	dobin scripts/exportvym || die "dobin failed"
	make_desktop_entry vym vym /usr/share/vym/icons/vym.png Education
}
