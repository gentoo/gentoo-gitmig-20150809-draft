# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.42.ebuild,v 1.3 2005/03/21 07:53:05 eradicator Exp $

inherit eutils flag-o-matic games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="mirror://sourceforge/zsnes/${PN}${PV//.}src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="opengl png"

# we need libsdl for headers on amd64, even though we'll technically be using
# the 32bit sdl from emul-linux-x86-sdl.
RDEPEND="virtual/libc
	>=media-libs/libsdl-1.2.0
	>=sys-libs/zlib-1.1
	amd64? ( app-emulation/emul-linux-x86-sdl )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98
	sys-devel/automake
	>=sys-devel/autoconf-2.58"

S="${WORKDIR}/${PN}_${PV//./_}"

multilib_check() {
	if use amd64; then
		if has_multilib_profile; then
			ewarn "Testing default."
			ABI_ALLOW="x86"

			# And until we get a real multilib portage...
			append-ldflags "-L/emul/linux/x86/usr/lib -L/emul/linux/x86/lib -L/usr/lib32 -L/lib32"
			ABI="x86"
		elif has_m32 ; then
			einfo "multilib detected, adding -m32 to CFLAGS."
			append-flags -m32
		else
			die "zsnes requires multilib support in gcc. please re-emerge gcc with multilib in USE and try again"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	cp "icons/48x48x32.png" "${T}/zsnes.png"
	epatch "${FILESDIR}"/${PV}-configure.patch
	aclocal && autoconf || die "autotools failed"
}

src_compile() {
	use amd64 && multilib_check
	cd src
	egamesconf \
		$(use_enable png libpng) \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/zsnes || die "dogamesbin failed"
	newman src/linux/zsnes.1 zsnes.6
	dodoc docs/{*.txt,README.LINUX}
	dohtml -r docs/Linux/*
	make_desktop_entry zsnes ZSNES zsnes.png
	doicon "${T}/zsnes.png"
	prepgamesdirs
}
