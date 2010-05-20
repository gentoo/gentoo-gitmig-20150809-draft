# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/packETH/packETH-1.6.3.ebuild,v 1.3 2010/05/20 10:31:33 pva Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Packet generator tool for ethernet"
HOMEPAGE="http://packeth.sourceforge.net/"
SRC_URI="mirror://sourceforge/packeth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-pixmaps.patch
}

src_compile() {
	tc-export CC
	default_src_compile
}

src_install() {
		insinto /usr/bin
		dobin packETH || die
		insinto /usr/share/pixmaps/packETH
		doins pixmaps/*
		dodoc ChangeLog README TODO
}
