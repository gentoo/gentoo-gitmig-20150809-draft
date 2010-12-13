# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/aoetools/aoetools-32.ebuild,v 1.1 2010/12/13 10:30:37 vapier Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="tools for ATA over Ethernet (AoE) network storage protocol"
HOMEPAGE="http://aoetools.sourceforge.net/"
SRC_URI="mirror://sourceforge/aoetools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-32-build.patch
	tc-export CC
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc NEWS README
}
