# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.40.ebuild,v 1.1 2004/12/26 22:22:37 vapier Exp $

inherit eutils flag-o-matic games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="mirror://sourceforge/zsnes/${PN}${PV//.}src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
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

S="${WORKDIR}/${PN}_${PV//./_}"

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
	cd "${S}"/src
	epatch "${FILESDIR}"/${PV}-LDFLAGS.patch
	aclocal && autoconf || die "autotools failed"
}

src_compile() {
	use amd64 && multilib_check
	cd src
	egamesconf $(use_enable opengl) || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/zsnes || die "dogamesbin failed"
	newman src/linux/zsnes.1 zsnes.6
	cd docs
	dodoc *.txt README.LINUX
	dohtml -r Linux/*
	prepgamesdirs
}
