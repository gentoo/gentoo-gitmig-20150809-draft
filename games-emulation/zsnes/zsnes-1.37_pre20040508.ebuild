# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.37_pre20040508.ebuild,v 1.6 2004/07/15 04:50:03 lv Exp $

inherit games eutils flag-o-matic

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://emuhost.com/ipher/zsnes/"
SRC_URI="http://ipher.emuhost.com/files/zsnes/ZSNESS_${PV/*2004}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="opengl"

# we need libsdl for headers on amd64, even though we'll technically be using
# the 32bit sdl from emul-linux-x86-sdl. 
RDEPEND="opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.0
	amd64? ( app-emulation/emul-linux-x86-sdl )
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98
	sys-devel/automake
	>=sys-devel/autoconf-2.58"

S="${WORKDIR}"

multilib_check() {
	if has_m32 ; then
		einfo "multilib detected, adding -m32 to CFLAGS. note that opengl"
		einfo "support probably wont work quite right."
		append-flags -m32
	else
		die "zsnes requires multilib support in gcc. please re-emerge gcc with multilib in USE and try again"
	fi
}

src_unpack() {
	unpack ${A}
	for f in * ; do
		mv ${f} ${f/zsnes\\\\}
	done
	cd src
	aclocal || die "aclocal failed"
	env WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
}

src_compile() {
	use amd64 && multilib_check

	cd src
	egamesconf \
		$(use_with opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/zsnes || die "dogamesbin failed"
	newman src/linux/zsnes.1 zsnes.6
	dodoc *.txt linux/*
	prepgamesdirs
}
