# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.4.1.ebuild,v 1.12 2006/06/22 13:04:51 flameeyes Exp $

KMNAME=kdemultimedia
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mpeg library"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="media-sound/cdparanoia"

PATCHES="${FILESDIR}/kdemultimedia-3.4.0-amd64.patch"

src_compile() {
	myconf="--with-cdparanoia --enable-cdparanoia"
	kde-meta_src_compile
}
