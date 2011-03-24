# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/packETH/packETH-1.7.1.ebuild,v 1.1 2011/03/24 17:24:06 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs autotools

DESCRIPTION="Packet generator tool for ethernet"
HOMEPAGE="http://packeth.sourceforge.net/"
SRC_URI="mirror://sourceforge/packeth/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="
	dev-util/pkgconfig
	${RDEPEND}
"

S="${WORKDIR}/${P/.1}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.6.5-forced-as-needed.patch"
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
