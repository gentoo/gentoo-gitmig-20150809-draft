# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-1.0.1.ebuild,v 1.5 2005/05/30 10:02:17 flameeyes Exp $

inherit eutils wxwidgets

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="gtk2 X flac"

DEPEND=">=dev-libs/libebml-0.7.2
	=media-libs/libmatroska-0.7.4
	media-libs/libogg
	media-libs/libvorbis
	dev-libs/expat
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/lzo
	X? ( =x11-libs/wxGTK-2.4* )
	flac? ( >=media-libs/flac-1.1.0 )"

src_compile() {
	if use X ; then
		if ! use gtk2 ; then
			need-wxwidgets gtk
		else
			need-wxwidgets gtk2
		fi
	fi
	econf || die "./configure died"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
	dohtml doc/mkvmerge-gui.html doc/images/*
}
