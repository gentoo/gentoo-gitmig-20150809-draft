# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.7-r1.ebuild,v 1.6 2005/01/16 22:34:36 vapier Exp $

inherit gnuconfig libtool

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="test"

DEPEND="virtual/libc
	test? ( >=dev-libs/check-0.8 )"

src_unpack() {
	hasq "test" ${FEATURES} && ! use test  && die "You must put test into your USE if you have FEATURES=test"

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
