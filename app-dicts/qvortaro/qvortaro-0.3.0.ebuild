# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/qvortaro/qvortaro-0.3.0.ebuild,v 1.2 2005/03/20 02:54:15 mr_bones_ Exp $

inherit eutils kde

DESCRIPTION="An Esperanto dictionary (currently only German)"
SRC_URI="http://download.berlios.de/qvortaro/qVortaro-${PV}.tar.bz2"
HOMEPAGE="http://qvortaro.berlios.de"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	>=x11-libs/qt-3.0.5"

S=${WORKDIR}/qVortaro-${PV}

src_compile() {
	cd ${S}
	qmake || die "qmake failed"
	set-kdedir
	kde_src_compile make || "make failed!"
}
src_install() {
	make INSTALL_ROOT=${D} install
}
