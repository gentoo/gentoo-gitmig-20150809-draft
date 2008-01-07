# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.21_pre15323.ebuild,v 1.1 2008/01/07 20:20:56 cardoe Exp $

inherit qt3 mythtv subversion

DESCRIPTION="A collection of themes for the MythTV project."
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	>=media-tv/mythtv-${PV}"

src_compile() {
	./configure --prefix="${ROOT}"/usr || die "configure died"

	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake -o "Makefile" myththemes.pro || die "qmake failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}
