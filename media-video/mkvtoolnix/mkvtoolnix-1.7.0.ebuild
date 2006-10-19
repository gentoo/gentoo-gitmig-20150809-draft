# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-1.7.0.ebuild,v 1.8 2006/10/19 23:44:16 flameeyes Exp $

inherit eutils wxwidgets flag-o-matic

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="wxwindows flac bzip2 lzo debug"

DEPEND=">=dev-libs/libebml-0.7.7
	>=media-libs/libmatroska-0.8.0
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
		need-wxwidgets gtk2
	fi
}

src_compile() {
	# Don't run strip while installing stuff, leave to portage the job.
	econf \
		$(use_enable lzo) \
		$(use_enable bzip2 bz2) \
		$(use_enable wxwindows gui) \
		$(use_enable debug) \
		$(use_with flac) \
		|| die "./configure died"

	emake STRIP="true" || die "make failed"
}

src_install() {
	einstall STRIP="true" || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml doc/mkvmerge-gui.html doc/images/*
	docinto examples
	dodoc examples/*
}
