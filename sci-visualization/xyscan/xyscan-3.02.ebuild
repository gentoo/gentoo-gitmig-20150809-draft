# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/xyscan/xyscan-3.02.ebuild,v 1.1 2008/07/03 22:55:15 markusle Exp $

EAPI="1"

inherit qt4

DESCRIPTION="Extract data points and errors from graphs"
HOMEPAGE="http://star.physics.yale.edu/~ullrich/xyscanDistributionPage/"
SRC_URI="http://star.physics.yale.edu/~ullrich/${PN}DistributionPage/${PV}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( x11-libs/qt-gui:4
			>=x11-libs/qt-4.3:4 )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-docs.patch
	sed -e "s:GENTOO_P:${P}:" -i xyscanWindow.cpp \
		|| die "Failed to fix docs path"
}

src_compile() {
	eqmake4 xyscan.pro
	emake || die "emake failed"
}

src_install() {
	exeinto "/usr/bin"
	doexe xyscan || die "Failed to install xyscan"
	insinto "/usr/share/doc/${P}"
	doins -r docs || die "Failed to install docs"
}
