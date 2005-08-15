# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.14-r1.ebuild,v 1.8 2005/08/15 14:18:34 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="ftp://ftp.funet.fi/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="arts nls sdl"

DEPEND="virtual/x11
	sdl? ( media-libs/libsdl )
	arts? ( kde-base/arts )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use nls && epatch "${FILESDIR}/${PV}-po-Makefile.patch"
	# bug #53903
	# http://www.trikaliotis.net/vicekb/vsa-2004-1
	epatch "${FILESDIR}/${PV}-console-security.patch"
}

src_compile() {
	# disabled gnome support since it doesn't work.
	# see bug #101901 and discussion.
	egamesconf \
		--enable-fullscreen \
		--disable-dependency-tracking \
		--disable-gnomeui \
		$(use_with arts) \
		$(use_enable nls) \
		$(use_with sdl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	local docdir="${D}${GAMES_LIBDIR}/${PN}/doc"

	make DESTDIR="${D}" install || die "make install failed"
	dohtml "${docdir}/"* || die "dohtml failed"
	dodoc \
		AUTHORS ChangeLog FEEDBACK README \
		"${docdir}/"{BUGS,NEWS,PETdoc.txt,TODO} \
		"${docdir}/"{cbm_basic_tokens.txt,drive_info.txt,mon.txt,serial.txt}
	rm -rf "${docdir}"
	prepgamesdirs
}
