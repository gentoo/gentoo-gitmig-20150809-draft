# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mktorrent/mktorrent-0.4.ebuild,v 1.2 2008/01/28 10:55:42 cla Exp $

inherit toolchain-funcs

DESCRIPTION="Simple command line utility to create BitTorrent metainfo files"
HOMEPAGE="http://mktorrent.sourceforge.net/"
SRC_URI="mirror://sourceforge/mktorrent/mktorrent-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-libs/openssl"

src_unpack() {
	unpack ${A}
	sed -i -e 's/^#DONT_STRIP/DONT_STRIP/' \
		-e "s/CC\t?= cc/CC = $(tc-getCC)/g" "${S}"/Makefile
}

src_install() {
	dobin mktorrent || die "dobin failed"
	dodoc README
}
