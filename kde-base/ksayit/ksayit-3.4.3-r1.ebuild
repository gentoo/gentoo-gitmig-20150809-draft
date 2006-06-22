# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksayit/ksayit-3.4.3-r1.ebuild,v 1.9 2006/06/22 13:32:27 flameeyes Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KD text-to-speech frontend app"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kttsd)
	$(deprange $PV $MAXKDEVER kde-base/arts)
	$(deprange-dual 3.4.1 $MAXKDEVER kde-base/kdemultimedia-arts)"

PATCHES="${FILESDIR}/${P}-pointer.patch"

src_compile() {
	myconf="--enable-ksayit-audio-plugins"
	kde-meta_src_compile
}
