# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksayit/ksayit-3.5.5.ebuild,v 1.7 2006/12/06 12:33:05 kloeri Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech frontend."
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kttsd)
	$(deprange $PV $MAXKDEVER kde-base/arts)
	$(deprange-dual $PV $MAXKDEVER kde-base/kdemultimedia-arts)"

RDEPEND="${DEPEND}"

src_compile() {
	myconf="--enable-ksayit-audio-plugins"
	kde-meta_src_compile
}
