# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hardlink++/hardlink++-0.02.ebuild,v 1.5 2012/05/19 10:42:23 ssuominen Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Save disk space by hardlinking identical files"
HOMEPAGE="http://www.sodarock.com/hardlink/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc34-optimize-help.patch \
		"${FILESDIR}"/${P}-gcc-43-compile-fix.patch

	rm -f Makefile
}

src_compile() {
	$(tc-getCXX) ${LDFLAGS} ${CXXFLAGS} hardlink.cpp -o ${PN}
}

src_install() {
	dobin ${PN}
	dodoc README
}
