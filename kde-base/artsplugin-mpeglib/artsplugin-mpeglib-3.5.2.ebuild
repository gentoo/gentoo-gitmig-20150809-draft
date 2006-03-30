# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpeglib/artsplugin-mpeglib-3.5.2.ebuild,v 1.2 2006/03/30 00:56:57 flameeyes Exp $

KMNAME=kdemultimedia
KMMODULE=mpeglib_artsplug
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="mpeglib plugin for arts"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="$(deprange 3.5.1 $MAXKDEVER kde-base/mpeglib)"

KMCOPYLIB="libmpeg mpeglib/lib/"
KMEXTRACTONLY="mpeglib/"

PATCHES="${FILESDIR}/${P}-libarts.patch"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}
