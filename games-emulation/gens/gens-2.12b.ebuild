# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12b.ebuild,v 1.6 2007/11/29 03:36:27 mr_bones_ Exp $

inherit flag-o-matic eutils games

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://gens.consolemul.com/"
SRC_URI="mirror://sourceforge/gens/gens-rc3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	>=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

S=${WORKDIR}/GensForLinux

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-romsdir.patch
	append-ldflags -Wl,-z,noexecstack
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS README
	prepgamesdirs
}
