# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.42.ebuild,v 1.5 2005/03/22 05:11:00 vapier Exp $

inherit eutils flag-o-matic games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="mirror://sourceforge/zsnes/${PN}${PV//.}src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="opengl png"

RDEPEND=">=media-libs/libsdl-1.2.0
	>=sys-libs/zlib-1.1
	amd64? ( app-emulation/emul-linux-x86-sdl )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98
	sys-devel/automake
	>=sys-devel/autoconf-2.58"

S="${WORKDIR}/${PN}_${PV//./_}"

pkg_setup() {
	use amd64 || return 0
	if has_m32 ; then
		append-flags -m32
	else
		eerror "Your compiler seems to be unable to compile 32bit code."
		eerror "Make sure you compile gcc with:"
		echo
		eerror "    USE=multilib FEATURES=-sandbox"
		die "Cannot produce 32bit code"
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
