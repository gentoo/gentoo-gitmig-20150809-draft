# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-1.4.2.ebuild,v 1.4 2005/05/30 10:02:17 flameeyes Exp $

inherit eutils wxwidgets

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="gtk2 wxwindows flac bzip2 lzo"

DEPEND=">=dev-libs/libebml-0.7.3
	>=media-libs/libmatroska-0.7.5
	media-libs/libogg
	media-libs/libvorbis
	dev-libs/expat
	sys-libs/zlib
	wxwindows? ( =x11-libs/wxGTK-2.4* )
	flac? ( >=media-libs/flac-1.1.0 )
	bzip2? ( app-arch/bzip2 )
	lzo? ( dev-libs/lzo )"

pkg_setup() {
	if use wxwindows; then
		if ! use gtk2 ; then
			need-wxwidgets gtk || die "You must compile wxGTK without wx_nogtk useflag."
		else
			need-wxwidgets gtk2 || die "You must compile wxGTK with gtk2 useflag."
		fi
	elif use gtk2; then
		einfo "You won't have gtk2 support as you requested not to use wxwindows."
	fi
}

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"

	epatch ${FILESDIR}/${PN}-configure-checks.patch
	./autogen.sh
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
