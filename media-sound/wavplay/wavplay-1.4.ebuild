# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavplay/wavplay-1.4.ebuild,v 1.13 2006/03/07 16:15:20 flameeyes Exp $

IUSE=""

inherit eutils toolchain-funcs

DESCRIPTION="A command line player/recorder for wav files"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/players/${P}.tar.gz mirror://gentoo/${P}.patch"
HOMEPAGE="http://orphan//"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 -sparc x86"

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}/${P}.patch"
	epatch "${FILESDIR}/${P}-gcc34.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CP="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" CCFLAGS="${CXXFLAGS}" LDOPTS="${LDFLAGS}" no_x || die
}

src_install () {
	dodir /usr/bin
	emake INSTDIR="${D}usr/bin" install_no_x || die
	# the motif frontend crashes and there are nicer player
	# for X anyway
	# no suid root install for old packages which use strcpy
	dodoc BUGS README
	doman *.1
}

