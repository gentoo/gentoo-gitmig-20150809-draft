# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-0.5.0.ebuild,v 1.4 2003/09/08 09:12:31 lanius Exp $

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="oggvorbis wxwindows"

DEPEND="~media-libs/libebml-0.4.4
	~media-libs/libmatroska-0.4.4
	oggvorbis? ( media-libs/libogg media-libs/libvorbis )
	wxwindows? ( x11-libs/wxGTK )"

src_compile() {
	local myconf=""
	use oggvorbis || myconf="${myconf} --disable-oggtest \
		--disable-vorbistest --without-ogg --without-vorbis"
	./configure ${myconf} || die "configure died"

	make || die "make failed"
}

src_install() {
	einstall || die
}
