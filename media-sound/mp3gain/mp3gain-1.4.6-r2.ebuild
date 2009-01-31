# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3gain/mp3gain-1.4.6-r2.ebuild,v 1.6 2009/01/31 02:00:22 jer Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE=""

MY_P=${P//./_}
S=${WORKDIR}

DESCRIPTION="MP3Gain automatically adjusts mp3s so that they all have the same volume"
HOMEPAGE="http://mp3gain.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.zip"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ~ppc ppc64 sparc x86"

DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	filter-flags -O*
	sed -i -e "s:CC=.*:CC=$(tc-getCC):" "${S}"/Makefile || die "Unable to override compiler selection"
	sed -i -e "s:CFLAGS= -Wall -O3 -DHAVE_MEMCPY:CFLAGS+= -Wall -DHAVE_MEMCPY:" "${S}"/Makefile ||
						die "Unable to convince build system to respect CFLAGS"
	epatch "${FILESDIR}"/${PV}-option-parser.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "Compile failed"
}

src_install () {
	dobin mp3gain
}
