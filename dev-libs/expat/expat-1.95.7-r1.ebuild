# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.7-r1.ebuild,v 1.2 2004/09/22 19:22:23 vapier Exp $

inherit gnuconfig libtool

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="makecheck"

DEPEND="virtual/libc
	makecheck? ( >=dev-libs/check-0.8 )"

src_unpack() {
	hasq "maketest" ${FEATURES} && ! use makecheck  && die "You must put makecheck into your USE if you have FEATURES=maketest"

	unpack ${A}
	cd "${S}"
	gnuconfig_update
	uclibctoolize
}

src_install() {
	einstall mandir="${D}/usr/share/man/man1" || die
	dodoc Changes README
	dohtml doc/
}
