# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdcss/libdvdcss-0.0.3.3.ebuild,v 1.16 2005/01/07 19:31:45 luckyduck Exp $

IUSE=""

MY_PV=${PV/3.3/3.ogle3}
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/libc"

src_compile() {

	econf --infodir=/usr/share/info ||die
	make || die
}

src_install() {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog README TODO
}
