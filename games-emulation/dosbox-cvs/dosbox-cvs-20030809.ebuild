# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox-cvs/dosbox-cvs-20030809.ebuild,v 1.15 2006/05/12 16:58:14 mr_bones_ Exp $

inherit games cvs

DESCRIPTION="DOS Emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="opengl debug"

DEPEND="media-libs/alsa-lib
	opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-net
	debug? ( sys-libs/ncurses )"

ECVS_SERVER="dosbox.cvs.sourceforge.net:/cvsroot/dosbox"
ECVS_MODULE="dosbox"
ECVS_TOP_DIR=${DISTDIR}/cvs-src/${PN}

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	./autogen.sh || die "autogen.sh failed"
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable debug debug heavy) \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "If you're using ati-drivers, you may need to use output=overlay"
	einfo "in the dosbox config file (see bug #57188)."
	echo
}
