# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picprog/picprog-1.5.ebuild,v 1.4 2004/06/29 13:25:49 vapier Exp $

DESCRIPTION="a pic16xxx series microcontroller programmer software for the simple serial port device"
HOMEPAGE="http://www.iki.fi/hyvatti/pic/${PN}.html"
SRC_URI="http://www.iki.fi/hyvatti/pic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-devel/gcc
	virtual/libc
	sys-apps/coreutils"
RDEPEND="virtual/libc"

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin picprog || die
	dodoc README
	dohtml picprog.html *.jpg *.png
	doman picprog.1
}
