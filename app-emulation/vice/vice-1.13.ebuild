# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.13.ebuild,v 1.3 2004/02/20 06:00:55 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://viceteam.bei.t-online.de/"
SRC_URI="ftp://ftp.funet.fi/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="sdl nls gnome arts"

RDEPEND="virtual/x11
	sdl? ( media-libs/libsdl )
	gnome? ( gnome-base/libgnomeui )
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	if [ `use nls` ] ; then
		cd ${S}/po
		epatch ${FILESDIR}/${PV}-po-Makefile.patch
	else
		sed -i \
			-e '/^SUBDIRS =/s:po::' ${S}/Makefile.in || \
				die "sed Makefile.in failed"
	fi
	# DESTDIR fix for bug 32544
	sed -i \
		-e '/^install:/ s/$/ install-am/' \
		-e 's:cd $(prefix):cd $(DESTDIR)$(prefix):' \
			${S}/data/fonts/Makefile.in || \
				die "sed data/fonts/Makefile.in failed"
}

src_compile() {
	egamesconf \
		--enable-fullscreen \
		--disable-dependency-tracking \
		`use_with sdl` \
		`use_with gnome gnomeui` \
		`use_with arts` \
		`use_enable nls` \
		|| die
	emake || die "emake failed"
}

src_install() {
	local docdir="${D}${GAMES_LIBDIR}/${PN}/doc"

	make DESTDIR=${D} install || die "make install failed"
	dohtml ${docdir}/* || die "dohtml failed"
	dodoc \
		AUTHORS ChangeLog FEEDBACK README \
		${docdir}/{BUGS,NEWS,PETdoc.txt,TODO} \
		${docdir}/{cbm_basic_tokens.txt,drive_info.txt,mon.txt,serial.txt} || \
			die "dodoc failed"
	rm -rf ${docdir}
	prepgamesdirs
}
