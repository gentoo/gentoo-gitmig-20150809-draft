# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrun/bbrun-1.6-r1.ebuild,v 1.4 2012/02/16 19:29:47 phajdan.jr Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="blackbox program execution dialog box"
HOMEPAGE="http://www.darkops.net/bbrun"
SRC_URI="http://www.darkops.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	x11-libs/libXpm
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake -C ${PN} CC="$(tc-getCC)" || die
}

src_install() {
	dobin ${PN}/${PN}
	dodoc Changelog README
}
