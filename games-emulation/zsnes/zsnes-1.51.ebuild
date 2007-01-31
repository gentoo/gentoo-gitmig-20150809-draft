# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.51.ebuild,v 1.6 2007/01/31 15:35:47 nyhm Exp $

inherit eutils autotools flag-o-matic toolchain-funcs games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="mirror://sourceforge/zsnes/${PN}${PV//./}src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="ao custom-cflags opengl png"

RDEPEND="media-libs/libsdl
	>=sys-libs/zlib-1.2.3-r1
	amd64? ( app-emulation/emul-linux-x86-sdl )
	!amd64? ( ao? ( media-libs/libao ) )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	dev-lang/nasm"

S=${WORKDIR}/${PN}_${PV//./_}/src

pkg_setup() {
	games_pkg_setup
	if use ao && [[ "${ARCH}" = "amd64" ]]; then
		ewarn "libao use flag is disabled on amd64 since deps cannot be met."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Workaround for old libz
	[[ "${ARCH}" = amd64 ]] && epatch "${FILESDIR}"/${P}-gzdirect.patch

	# Remove hardcoded CFLAGS and LDFLAGS
	if use custom-cflags; then
		sed -i -e '/^\s*CFLAGS=.* -fomit-frame-pointer /d' \
			configure.in || die
		append-flags -fomit-frame-pointer -D__RELEASE__
	else
		strip-flags
	fi
	sed -i \
		-e 's:^\s*STRIP="-s":STRIP="":'	\
		-e 's:^\s*CFLAGS=.* -I\/usr\/local\/include .*$:CFLAGS="${CFLAGS} -I.":'	\
		-e '/^\s*LDFLAGS=.* -L\/usr\/local\/lib /d'		\
		configure.in || die

	eautoreconf
}

src_compile() {
	tc-export CC

	use amd64 && multilib_toolchain_setup x86

	local myconf=""
	use custom-cflags && myconf="--disable-cpucheck force_arch=no"

	if use ao && [[ "${ARCH}" != amd64 ]]; then
		myconf="${myconf} --enable-libao"
	else
		myconf="${myconf} --disable-libao"
	fi

	egamesconf \
		$(use_enable png libpng) \
		$(use_enable opengl) \
		--disable-debug \
		--enable-release \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	dogamesbin zsnes || die "dogamesbin failed"
	newman linux/zsnes.1 zsnes.6
	dodoc ../docs/{*.txt,README.LINUX}
	dohtml -r ../docs/Linux/*
	make_desktop_entry zsnes ZSNES zsnes.png
	newicon icons/48x48x32.png ${PN}.png
	prepgamesdirs
}
