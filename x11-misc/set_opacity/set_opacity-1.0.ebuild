# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/set_opacity/set_opacity-1.0.ebuild,v 1.1 2011/07/18 10:10:10 maksbotan Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Tool for set real compositing for windows through window's id, process' pid etc."
HOMEPAGE="http://www.xvilka.narod.ru/downloads.xhtml"
SRC_URI="http://www.xvilka.narod.ru/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libXrender"
RDEPEND=${DEPEND}

src_prepare(){
	epatch "${FILESDIR}"/makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin set_opacity || die "dobin failed"
}
