# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/devede/devede-2.13.ebuild,v 1.2 2007/06/17 22:07:29 drac Exp $

DESCRIPTION="DVD Video Creator"
HOMEPAGE="http://www.rastersoft.com/programas/devede.html"
SRC_URI="http://www.rastersoft.com/descargas/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-lang/python-2.4
	dev-python/pygtk
	>=media-video/mplayer-1.0_rc1
	media-video/dvdauthor
	media-video/vcdimager
	dev-python/psyco
	virtual/cdrtools"
DEPEND="${RDEPEND}"

src_install() {
	DESTDIR="${D}" ./install.sh || die "install.sh failed."
	rm -rf "${D}"/usr/share/doc/devede
	use doc && dohtml docs/*
}

pkg_postinst() {
	elog "To create DIVX/MPEG4 files, be sure that MPlayer is compiled with LAME support."
	elog "In this case you want to check for both the encode and mp3 USE flags."
	elog ""
	elog "To change the font used to render the subtitles, choose a TrueType font you like"
	elog "and copy it in \$HOME/.spumux directory, renaming it to devedesans.ttf."
}
