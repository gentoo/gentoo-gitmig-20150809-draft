# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/nestra/nestra-0.66-r1.ebuild,v 1.12 2006/02/05 14:39:14 blubb Exp $

inherit eutils toolchain-funcs flag-o-matic games

PATCH="${P/-/_}-7.diff"
DESCRIPTION="NES emulation for Linux/x86"
HOMEPAGE="http://nestra.linuxgames.com/"
SRC_URI="http://nestra.linuxgames.com/${P}.tar.gz
	mirror://debian/pool/contrib/n/nestra/${PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2-r7 )"
DEPEND="${RDEPEND}
	virtual/x11"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup
	use amd64 && export ABI=x86
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PATCH} "${FILESDIR}"/${P}-exec-stack.patch
	append-ldflags -Wl,-z,noexecstack
	sed -i \
		-e "s:-L/usr/X11R6/lib:${LDFLAGS}:" \
		-e 's:-O2 ::' \
		-e "s:gcc:$(tc-getCC) ${CFLAGS}:" \
		-e "s:ld:$(tc-getLD) $(raw-ldflags):" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dogamesbin nestra || die "dogamesbin failed"
	dodoc BUGS CHANGES README
	doman nestra.6
	prepgamesdirs
}
