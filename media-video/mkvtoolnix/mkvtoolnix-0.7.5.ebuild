# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-0.7.5.ebuild,v 1.1 2003/11/21 19:52:04 mholzer Exp $

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="oggvorbis wxwindows X"

DEPEND=">=media-libs/libebml-0.6.2
	>=media-libs/libmatroska-0.6.1
	oggvorbis? ( media-libs/libogg media-libs/libvorbis )
	X? ( >=x11-libs/wxGTK-2.4.1 )
	dev-libs/lzo"

src_compile() {
	local myconf=""

	use oggvorbis || myconf="${myconf} --disable-oggtest \
		--disable-vorbistest --without-ogg --without-vorbis"
	./configure ${myconf} || die "configure died"

	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dohtml doc/mkvmerge-gui.html
}
