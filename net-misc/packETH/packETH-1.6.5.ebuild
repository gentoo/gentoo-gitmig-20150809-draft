# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/packETH/packETH-1.6.5.ebuild,v 1.3 2011/03/24 17:15:33 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs autotools

DESCRIPTION="Packet generator tool for ethernet"
HOMEPAGE="http://packeth.sourceforge.net/"
SRC_URI="mirror://sourceforge/packeth/${P}.tar.bz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="
	dev-util/pkgconfig
	${RDEPEND}
"

src_prepare() {
	epatch "${FILESDIR}/${P}-forced-as-needed.patch"
	eautomake
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README || die
}
