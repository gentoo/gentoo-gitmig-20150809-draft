# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes-extra/mythtv-themes-extra-0.21_p16760.ebuild,v 1.1 2008/04/01 04:22:31 cardoe Exp $

inherit qt3 mythtv

DESCRIPTION="A collection of themes for the MythTV project."
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	=media-tv/mythtv-${MY_PV}*"

src_compile() {
	./configure --prefix="${ROOT}"/usr || die "configure died"

	eqmake3 themes.pro -o "Makefile" || die "eqmake3 failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}
