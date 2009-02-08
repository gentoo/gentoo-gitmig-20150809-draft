# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/devede/devede-3.12c.ebuild,v 1.1 2009/02/08 10:29:10 aballier Exp $

NEED_PYTHON=2.4

inherit multilib python

DESCRIPTION="Program to create video CDs and DVDs, suitable to be played in home DVD players."
HOMEPAGE="http://www.rastersoft.com/programas/devede.html"
SRC_URI="http://www.rastersoft.com/descargas/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="psyco"

RDEPEND=">=x11-libs/gtk+-2.6
	dev-python/pygtk
	>=media-video/mplayer-1.0_rc1
	media-video/dvdauthor
	media-video/vcdimager
	psyco? ( dev-python/psyco )
	virtual/cdrtools"
DEPEND=""

S=${WORKDIR}/${P%*b}

src_install() {
	./install.sh prefix="/usr" libdir="/usr/$(get_libdir)" \
		pkgdocdir="/usr/share/doc/${PF}" DESTDIR="${D}" \
		|| die "install.sh failed."
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
	elog "To create DIVX/MPEG4 files, be sure that MPlayer is compiled with LAME support."
	elog "In this case you want to check for both the encode and mp3 USE flags."
	elog "To change the font used to render the subtitles, choose a TrueType font you like"
	elog "and copy it in \$HOME/.spumux directory, renaming it to devedesans.ttf."
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
