# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/jugglemaster/jugglemaster-0.4.ebuild,v 1.6 2008/04/28 06:19:10 mr_bones_ Exp $

inherit eutils toolchain-funcs wxwidgets games

DESCRIPTION="A siteswap animator"
HOMEPAGE="http://icculus.org/jugglemaster/"
SRC_URI="http://icculus.org/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="ffmpeg"

DEPEND="=x11-libs/wxGTK-2.6*
	ffmpeg? ( media-video/ffmpeg )"

pkg_setup() {
	games_pkg_setup
	WX_GTK_VER=2.6 need-wxwidgets gtk2
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use ffmpeg ; then
		epatch "${FILESDIR}/${P}"-ffmpeg.patch
		sed -i \
			-e '/HAVE_AVCODEC_H/s:$: -I/usr/include/libavcodec:' \
			-e "s/libavcodec/ffmpeg/" \
			src/jmdlx/Makefile \
			|| die "sed Makefile (ffmpeg) failed"
		sed -i \
			-e "/^FFMPEG_PREFIX/s:=.*:=/usr/include:" \
			-e "/^HAVE_FFMPEG/s:0:1:" \
			Makefile.cfg \
			|| die "sed Makefile.cfg failed"
	fi
	sed -i \
		-e '/wx-config --ldflags/d' \
		-e "s:wx-config:${WX_CONFIG}:" \
		src/jmdlx/Makefile \
		|| die "sed Makefile (wx) failed"
}

src_compile() {
	emake \
		-C src/jmdlx \
		CXX=$(tc-getCXX) \
		|| die "emake failed"
}

src_install () {
	dogamesbin src/jmdlx/jmdlx || die "dogamesbin failed"
	dodoc ChangeLog README TODO
	prepgamesdirs
}
