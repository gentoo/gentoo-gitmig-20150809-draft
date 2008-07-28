# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-1.8.1.ebuild,v 1.4 2008/07/28 21:31:06 carlo Exp $

EAPI=1

inherit qt3

DESCRIPTION="View Your Mind -- a mindmap tool"
HOMEPAGE="http://www.insilmaril.de/vym/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXext"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Change installation directory and demo path
	sed -i \
		-e "s@/usr/local/bin@/usr@g" \
		-e "s@demo\.path.*@demo.path = \$\${INSTALLDIR}/share/doc/${PF}@" \
		vym.pro || die "sed failed"

	${QTDIR}/bin/qmake -o Makefile vym.pro

	# Remove stripping stuff
	sed -i \
		-e "/-strip/d" Makefile || die "sed failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	dobin scripts/exportvym
	dobin scripts/vym2html.sh
	dobin scripts/vym2txt.sh
}
