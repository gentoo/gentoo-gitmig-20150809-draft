# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tic98/tic98-1.01-r1.ebuild,v 1.3 2005/08/02 15:48:13 sekretarz Exp $

inherit eutils

DESCRIPTION="compressor for black-and-white images, in particular scanned documents"
HOMEPAGE="http://www.cs.waikato.ac.nz/~singlis/"
SRC_URI="http://www.cs.waikato.ac.nz/~singlis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff
    	emake all || die
	emake all2 || die
}

src_install() {
	dodir /usr/bin
	make BIN=${D}usr/bin install || die
}
