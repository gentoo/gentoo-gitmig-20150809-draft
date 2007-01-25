# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/qvortaro/qvortaro-0.3.1.ebuild,v 1.2 2007/01/25 04:50:57 genone Exp $

inherit eutils qt3

DESCRIPTION="An Esperanto dictionary (currently only German)"
SRC_URI="http://download.berlios.de/qvortaro/qVortaro-${PV}.tar.bz2"
HOMEPAGE="http://qvortaro.berlios.de"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	$(qt_min_version 3.1)"

S=${WORKDIR}/qVortaro-${PV}

src_compile() {
	cd ${S}
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake || die "qmake failed"
	emake || die "emake failed"
}
src_install() {
	make INSTALL_ROOT=${D} install
	doicon src/icon/${PN}.png
	make_desktop_entry qvortaro "qVortaro"
}
pkg_postinst() {
	elog "additional dictionaries at http://qvortaro.berlios.de/dictionaries.php"
}
