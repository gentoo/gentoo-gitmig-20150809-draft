# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-akode/artsplugin-akode-3.5.2-r1.ebuild,v 1.11 2006/09/03 10:11:18 kloeri Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=akode_artsplugin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdemultimedia-3.5-patchset-01.tar.bz2"

DESCRIPTION="aKode aRts plugin."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="media-libs/akode
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts)"

KMCOPYLIB="libartsbuilder arts/runtime"

src_compile() {
	local myconf="--with-akode"

	kde-meta_src_compile
}
