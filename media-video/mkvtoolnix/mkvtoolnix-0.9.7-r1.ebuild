# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-0.9.7-r1.ebuild,v 1.3 2005/05/30 10:02:17 flameeyes Exp $

inherit eutils wxwidgets

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk2 X oggvorbis"

DEPEND=">=dev-libs/libebml-0.7.2
	>=media-libs/libmatroska-0.7.4
	oggvorbis? ( media-libs/libogg media-libs/libvorbis media-libs/flac )
	X? ( =x11-libs/wxGTK-2.4* )
	dev-libs/expat
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/lzo"

src_unpack() {
	unpack ${A} || die "Failed to unpack ${A}"
	cd ${S} || die "Failed to cd ${S}"
}

src_compile() {
	if use X ; then
		if ! use gtk2 ; then
			need-wxwidgets gtk
		else
			need-wxwidgets gtk2
		fi
	fi
	./configure || die "configure died"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dohtml doc/mkvmerge-gui.html doc/images/*
}
