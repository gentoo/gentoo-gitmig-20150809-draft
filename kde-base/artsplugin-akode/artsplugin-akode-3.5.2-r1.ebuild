# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-akode/artsplugin-akode-3.5.2-r1.ebuild,v 1.6 2006/05/29 21:47:51 weeve Exp $

KMNAME=kdemultimedia
KMMODULE=akode_artsplugin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="akode arts plugin"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE=""
DEPEND="media-libs/akode
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts)"

KMCOPYLIB="libartsbuilder arts/runtime"

PATCHES="${FILESDIR}/${P}-memleak.patch"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
	kde_pkg_setup
}

src_compile() {
	local myconf="--with-akode"

	kde-meta_src_compile
}
