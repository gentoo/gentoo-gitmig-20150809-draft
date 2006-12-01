# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/nestra/nestra-0.66-r1.ebuild,v 1.16 2006/12/01 21:31:46 wolf31o2 Exp $

inherit eutils toolchain-funcs flag-o-matic multilib games

PATCH="${P/-/_}-7.diff"
DESCRIPTION="NES emulation for Linux/x86"
HOMEPAGE="http://nestra.linuxgames.com/"
SRC_URI="http://nestra.linuxgames.com/${P}.tar.gz
	mirror://debian/pool/contrib/n/nestra/${PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2-r7 )
	x11-libs/libX11"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PATCH} "${FILESDIR}"/${P}-exec-stack.patch
	append-ldflags -Wl,-z,noexecstack
	use amd64 && multilib_toolchain_setup x86
	sed -i \
		-e "s:-L/usr/X11R6/lib:${LDFLAGS}:" \
		-e 's:-O2 ::' \
		-e "s:gcc:$(tc-getCC) ${CFLAGS}:" \
		-e "s:ld:$(tc-getLD) $(raw-ldflags):" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	use amd64 && multilib_toolchain_setup x86
	games_src_compile
}

src_install() {
	dogamesbin nestra || die "dogamesbin failed"
	dodoc BUGS CHANGES README
	doman nestra.6
	prepgamesdirs
}
