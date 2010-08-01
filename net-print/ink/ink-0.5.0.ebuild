# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.5.0.ebuild,v 1.3 2010/08/01 20:25:14 phajdan.jr Exp $

EAPI="2"
inherit eutils

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="mirror://sourceforge/ink/${P/_}.tar.gz"
HOMEPAGE="http://ink.sourceforge.net/"

SLOT="0"
KEYWORDS="~amd64 x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=">net-print/libinklevel-0.8"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_install () {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die
}
