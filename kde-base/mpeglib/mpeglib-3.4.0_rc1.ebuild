# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.4.0_rc1.ebuild,v 1.2 2005/03/17 11:43:04 greg_g Exp $

KMNAME=kdemultimedia
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mpeg library"
KEYWORDS="~x86"
IUSE=""
DEPEND="media-sound/cdparanoia"

myconf="--with-cdparanoia --enable-cdparanoia"

src_unpack() {
	kde-meta_src_unpack
	epatch "${FILESDIR}/kdemultimedia-3.4.0-amd64.patch"
}
