# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-0.5.0.ebuild,v 1.1 2003/07/20 08:01:32 raker Exp $

IUSE="oggvorbis wxwindows"

S=${WORKDIR}/${P}

DESCRIPTION="Tools to create, alter, and inspect Matroska files."
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="~media-libs/libebml-0.4.4
	~media-libs/libmatroska-0.4.4
	oggvorbis? ( media-libs/libogg media-libs/libvorbis )
	wxwindows? ( >=media-libs/wxGTK )"

src_compile() {
	local myconf=""

	use oggvorbis || myconf="${myconf} --disable-oggtest \
		--disable-vorbistest --without-ogg --without-vorbis"

	./configure ${myconf} 

	make || die
}

src_install () {
	einstall || die
}

