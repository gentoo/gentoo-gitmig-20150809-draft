# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-1.10.8.20041007.ebuild,v 1.7 2006/12/01 20:08:50 wolf31o2 Exp $

GAMES_USE_SDL="nojoystick"
inherit flag-o-matic games

DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
HOMEPAGE="http://www.BZFlag.org/"
SRC_URI="mirror://sourceforge/bzflag/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dedicated"

RDEPEND="virtual/libc
	!dedicated? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:^CFLAGS=.*::' \
		-e 's:^CXXFLAGS=.*::' \
		-e 's:-mcpu=$host_cpu::' \
		configure \
		|| die "sed failed"
	filter-flags -fno-default-inline
}

src_compile() {
	if use dedicated ; then
		ewarn
		ewarn "You are building a server-only copy of BZFlag"
		ewarn
		egamesconf \
			--disable-dependency-tracking \
			--disable-client || die
	else
		egamesconf --disable-dependency-tracking || die
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README.UNIX TODO README ChangeLog BUGS PORTING
	prepgamesdirs
}
