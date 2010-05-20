# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/packETH/packETH-1.6.5.ebuild,v 1.1 2010/05/20 10:53:06 pva Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Packet generator tool for ethernet"
HOMEPAGE="http://packeth.sourceforge.net/"
SRC_URI="mirror://sourceforge/packeth/${P}.tar.bz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_compile() {
	tc-export CC
	default
}

src_install() {
	emake DESTDIR="${D}" install || die
#		insinto /usr/bin
#		dobin packETH || die
#		insinto /usr/share/pixmaps/packETH
#		doins src/pixmaps/* || die
	dodoc AUTHORS README || die
}
