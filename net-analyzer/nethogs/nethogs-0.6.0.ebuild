# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nethogs/nethogs-0.6.0.ebuild,v 1.1 2005/04/03 17:20:23 vanquirius Exp $

inherit eutils

HOMEPAGE="http://nethogs.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DESCRIPTION="A small 'net top' tool, grouping bandwidth by process"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libpcap"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.diff
}

src_compile() {
	# There is currently no configure script within the nethogs package:
	# econf || die

	emake || die "emake failed"
}

src_install() {
	# Not using make install or einstall because of the hardcoded paths in Makefile
	dosbin nethogs
	doman nethogs.8
	dodoc Changelog DESIGN README
}
