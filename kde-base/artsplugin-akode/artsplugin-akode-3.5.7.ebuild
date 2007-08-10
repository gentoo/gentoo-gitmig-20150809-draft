# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-akode/artsplugin-akode-3.5.7.ebuild,v 1.6 2007/08/10 14:57:16 angelos Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=akode_artsplugin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}"

DESCRIPTION="aKode aRts plugin."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND="media-libs/akode
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts)"
DEPEND="${RDEPEND}"

KMCOPYLIB="libartsbuilder arts/runtime"

src_compile() {
	local myconf="--with-akode"

	kde-meta_src_compile
}
