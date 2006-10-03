# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.5.1.ebuild,v 1.14 2006/10/03 13:09:01 flameeyes Exp $

KMNAME=kdemultimedia
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mpeg library"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""
RDEPEND="media-sound/cdparanoia
	|| ( (
			x11-libs/libXext
			x11-libs/libXxf86dga
			x11-libs/libXxf86vm
		) <virtual/x11-7 )
	media-libs/libvorbis"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xf86dgaproto
			x11-proto/xf86vidmodeproto
			x11-proto/videoproto
		) <virtual/x11-7 )"

src_compile() {
	myconf="--with-cdparanoia --enable-cdparanoia"
	kde-meta_src_compile
}
