# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/widelands/widelands-0.0.9.5-r1.ebuild,v 1.1 2006/03/21 21:57:17 jokey Exp $

inherit eutils games flag-o-matic

DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://widelands.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-b${PV:4:1}half-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug nls"

DEPEND="media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/sdl-ttf
	sys-libs/zlib"
RDEPEND=${DEPEND}

S=${WORKDIR}/${PN}-b9half

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/widelands-0.0.9-amd64.patch"
	epatch "${FILESDIR}/widelands-makefile.patch"
	epatch "${FILESDIR}/widelands-0.0.9.5-gcc41.patch"
	sed -i -e "s:__ppc__:__PPC__:g" "${S}/src/machdep.h" || die "sed failed"

	if use nls ; then
		cd ${S}/locale
		cp ../utils/*.py .
	fi
}

src_compile() {
	filter-flags -fomit-frame-pointer
	use debug || export BUILD="release"
	use elibc_glibc && export IMPLICIT_LIBINTL=1
	emake || die "emake failed"
	unset BUILD IMPLICIT_LIBINTL

	if use nls ; then
		cd ${S}/locale
		./buildcat.py
		rm *.p* .cvsignore tmp
	fi
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	insinto "${dir}"

	if use nls ; then
		doins -r fonts maps pics tribes worlds campaigns locale || die "doins failed"
	else
		doins -r fonts maps pics tribes worlds campaigns || die "doins failed"
	fi
	exeinto "${dir}"
	doexe ${PN} || die "copying widelands"
	games_make_wrapper widelands ./widelands "${dir}"
	dodoc AUTHORS ChangeLog README.developers

	newicon pics/wl-ico-48.png widelands.png
	make_desktop_entry widelands Widelands widelands.png
	prepgamesdirs
}
