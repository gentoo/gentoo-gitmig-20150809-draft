# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fmdrv/fmdrv-1.0.7.ebuild,v 1.7 2006/03/07 14:43:42 flameeyes Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="Console mode MIDI player with builtin userland OPL2 driver"
HOMEPAGE="http://bisqwit.iki.fi/source/fmdrv.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

KEYWORDS="x86 amd64"
SLOT="0"

LICENSE="as-is"

src_compile() {
	emake fmdrv \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin fmdrv
	dodoc README
	dohtml README.html
}

pkg_postinst() {
	einfo "If you want to use AdLib (FM OPL2), you need to setuid /usr/bin/fmdv."
	einfo "chmod 4711 /usr/bin/fmdrv"
}
