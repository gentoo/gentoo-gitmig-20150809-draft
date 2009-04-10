# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-1.12.2.ebuild,v 1.1 2009/04/10 13:21:08 yngwin Exp $

EAPI=2
inherit eutils qt4

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
	x11-libs/libX11
	x11-libs/libXext"

src_prepare() {
	qt4_src_prepare

	# Change installation directory and demo path
	sed -i \
		-e "s@/usr/local@/usr@g" \
		-e "s@doc/packages/vym@doc/vym@g" \
		vym.pro || die "sed failed"
}

src_configure() {
	eqmake4

	# Remove stripping stuff
	sed -i "/-strip/d" Makefile || die "sed failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	make_desktop_entry vym vym /usr/share/vym/icons/vym.png Education
	dobin scripts/exportvym || die "dobin failed"
}
