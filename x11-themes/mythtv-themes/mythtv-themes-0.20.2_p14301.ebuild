# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.20.2_p14301.ebuild,v 1.5 2008/12/15 20:01:35 angelos Exp $

EAPI=1

inherit qt3 mythtv subversion

DESCRIPTION="A collection of themes for the MythTV project."
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/qt:3
	=media-tv/mythtv-${MY_PV}*"

src_compile() {
	./configure --prefix=/usr || die "configure died"

	"${QTDIR}"/bin/qmake QMAKE="${QTDIR}"/bin/qmake -o "Makefile" myththemes.pro || die "qmake failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}
