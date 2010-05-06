# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmapsi/nmapsi-0.2_alpha3.ebuild,v 1.2 2010/05/06 10:14:30 ssuominen Exp $

EAPI=2
inherit cmake-utils eutils

MY_P=${PN}4-${PV/_/-}

DESCRIPTION="A Qt4 frontend to nmap"
HOMEPAGE="http://www.nmapsi4.org/"
SRC_URI="http://nmapsi4.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}
	net-analyzer/nmap"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS NEWS README TODO Translation"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
}

src_install() {
	cmake-utils_src_install
	fperms 755 /usr/bin/nmapsi4{,-logr}
}
