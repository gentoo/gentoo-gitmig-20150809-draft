# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.4.0_rc1.ebuild,v 1.1 2005/03/06 01:34:59 motaboy Exp $

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
	epatch "${FILESDIR}/kdemultimedia-3.4.0_beta1-amd64.patch"
}

