# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.8_beta2.ebuild,v 1.2 2004/06/06 03:00:58 dragonheart Exp $

inherit kde eutils
need-kde 3

MY_P=${P/_/}

DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
HOMEPAGE="http://arson.sourceforge.net/"
SRC_URI="mirror://sourceforge/arson/${MY_P}.tar.bz2"
LICENSE="GPL-2"
IUSE="oggvorbis"

DEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-sound/bladeenc-0.94.2
	>=app-cdr/cdrtools-1.11.24
	>=media-sound/normalize-0.7.4
	oggvorbis? ( media-libs/libvorbis
		media-libs/libogg )
	>=media-sound/lame-3.92
	>=app-cdr/cdrdao-1.1.5
	>=media-libs/flac-1.1.0"

# ldd ./usr/bin/arson | cut -f 3 -d ' ' | xargs -n1 qpkg -f | sort | uniq
# app-admin/fam *
# dev-libs/expat *
# kde-base/kdelibs *
# media-libs/flac *
# media-libs/fontconfig *
# media-libs/freetype *
# media-libs/jpeg *
# media-libs/libart_lgpl *
# media-libs/libmng *
# media-libs/libogg *
# media-libs/libpng *
# media-libs/libvorbis *
# sys-devel/gcc *
# sys-libs/glibc *
# sys-libs/zlib *
# x11-base/xfree *
# x11-libs/qt *

# Runtime programs.
#	media-video/vcdimager

KEYWORDS="x86 ~sparc ~amd64"
S=${WORKDIR}/${PN}


src_compile() {
	use oggvorbis && myconf="$myconf --with-vorbis" || myconf="$myconf --without-vorbis"
	myconf="$myconf --with-flac"
	kde_src_compile
}
