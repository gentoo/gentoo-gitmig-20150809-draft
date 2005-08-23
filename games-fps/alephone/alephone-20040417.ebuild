# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone/alephone-20040417.ebuild,v 1.2 2005/08/23 00:59:21 hparker Exp $

inherit games eutils

DESCRIPTION="An enhanced version of the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
SRC_URI="mirror://sourceforge/marathon/aleph-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="opengl lua"

DEPEND="opengl? ( virtual/opengl )
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-net
	lua? ( dev-lang/lua )"

S=${WORKDIR}/aleph_${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${PV}-gcc34.patch
	NO_CONFIGURE=bah ./autogen.sh || die "autogen failed"
}

src_compile() {
	egamesconf $(use_enable opengl) || die
	if ! use lua ; then
		# stupid configure script doesnt have an option
		sed -i '/HAVE_LUA/d' config.h || die "sed HAVE_LUA"
		sed -i '/^LIBS/s:-llua -llualib::' $(find -name Makefile) || die "sed -llua"
	fi
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README docs/Cheat_Codes
	dohtml docs/MML.html
	prepgamesdirs
}
