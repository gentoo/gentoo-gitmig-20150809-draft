# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-1.5.5.ebuild,v 1.7 2006/10/19 23:44:16 flameeyes Exp $

inherit eutils wxwidgets flag-o-matic

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="wxwindows flac bzip2 lzo"

DEPEND=">=dev-libs/libebml-0.7.3
	>=media-libs/libmatroska-0.7.5
	media-libs/libogg
	media-libs/libvorbis
	dev-libs/expat
	sys-libs/zlib
	wxwindows? ( =x11-libs/wxGTK-2.6* )
	flac? ( ~media-libs/flac-1.1.2 )
	bzip2? ( app-arch/bzip2 )
	lzo? ( dev-libs/lzo )"

pkg_setup() {
	WX_GTK_VER="2.6"
	if use wxwindows; then
		need-wxwidgets gtk2 || die "You must compile wxGTK with X useflag."
	fi

	# filter out -fforce-addr as it leads to segfaults, see Bug #113396
	filter-flags -fforce-addr
}

src_compile() {
	econf \
		$(use_enable lzo) \
		$(use_enable bzip2 bz2) \
		$(use_enable wxwindows gui) \
		$(use_with flac) \
		|| die "./configure died"

	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml doc/mkvmerge-gui.html doc/images/*
}
