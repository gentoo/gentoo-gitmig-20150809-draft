# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/jugglemaster/jugglemaster-0.4.ebuild,v 1.2 2005/08/24 04:45:48 mr_bones_ Exp $

DESCRIPTION="A siteswap animator"
HOMEPAGE="http://icculus.org/jugglemaster/"
SRC_URI="http://icculus.org/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="ffmpeg"

DEPEND="x11-libs/wxGTK
	ffmpeg? ( media-video/ffmpeg )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use ffmpeg ; then
		sed -i \
			-e "s/libavcodec/ffmpeg/" \
			src/jmdlx/Makefile \
			|| die "sed failed"
		sed -i \
			-e "/^FFMPEG_PREFIX/s:=.*:=/usr/include:" \
			-e "/^HAVE_FFMPEG/s:0:1:" \
			Makefile.cfg \
			|| die "sed failed"
	fi
}

src_compile() {
	emake -C src/jmdlx || die "emake failed"
}

src_install () {
	dobin src/jmdlx/jmdlx || die "dobin failed"
	dodoc ChangeLog README TODO
}
