# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-1.10.0.ebuild,v 1.2 2007/11/03 13:49:31 coldwind Exp $

inherit qt4

DESCRIPTION="View Your Mind -- a mindmap tool"
HOMEPAGE="http://www.insilmaril.de/vym/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.3)"
RDEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXext"

QT4_BUILT_WITH_USE_CHECK="qt3support"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Change installation directory and demo path
	sed -i \
		-e "s@/usr/local/bin@/usr@g" \
		-e "s@demo\.path.*@demo.path = \$\${INSTALLDIR}/share/doc/${PF}@" \
		vym.pro || die "sed failed"

	qmake

	# Remove stripping stuff
	sed -i \
		-e "/-strip/d" Makefile || die "sed failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	dobin scripts/exportvym
}
