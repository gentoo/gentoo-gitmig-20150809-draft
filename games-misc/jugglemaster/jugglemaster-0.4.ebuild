# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/jugglemaster/jugglemaster-0.4.ebuild,v 1.10 2010/09/03 17:10:19 nyhm Exp $

EAPI=2
WX_GTK_VER="2.6"
inherit eutils wxwidgets flag-o-matic games

DESCRIPTION="A siteswap animator"
HOMEPAGE="http://icculus.org/jugglemaster/"
SRC_URI="http://icculus.org/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ffmpeg"

DEPEND="x11-libs/wxGTK:2.6[X]
	ffmpeg? ( media-video/ffmpeg )"

src_prepare() {
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
	#bug #324251 (UINT64_C vs ffmpeg headers)
	append-flags -D__STDC_CONSTANT_MACROS
}

src_compile() {
	emake -C src/jmdlx || die "emake failed"
}

src_install () {
	dogamesbin src/jmdlx/jmdlx || die "dogamesbin failed"
	dodoc ChangeLog README TODO
	prepgamesdirs
}
