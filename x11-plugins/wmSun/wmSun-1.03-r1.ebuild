# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSun/wmSun-1.03-r1.ebuild,v 1.5 2009/06/04 00:06:30 tcunha Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="dockapp which displays the rise/set time of the sun"
HOMEPAGE="http://dockapps.org/file.php/id/16"
SRC_URI="http://dockapps.org/download.php/id/23/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~mips ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S="${WORKDIR}/${P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake clean || die "make clean failed"
	emake CC="$(tc-getCC)" LIBDIR="/usr/$(get_libdir)" || die "parallel make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ../{BUGS,TODO}
}
