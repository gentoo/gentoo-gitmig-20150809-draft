# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/flawfinder/flawfinder-1.26-r1.ebuild,v 1.1 2006/02/06 10:09:21 truedfx Exp $

inherit eutils

DESCRIPTION="Examines C/C++ source code for security flaws"
HOMEPAGE="http://www.dwheeler.com/flawfinder/"
SRC_URI="http://www.dwheeler.com/flawfinder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-linenumbers.patch
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ChangeLog INSTALL.txt README announcement
	dodoc flawfinder.pdf
}
