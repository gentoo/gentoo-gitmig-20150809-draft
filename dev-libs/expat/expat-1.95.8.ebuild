# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.8.ebuild,v 1.7 2005/01/11 21:17:16 vapier Exp $

inherit gnuconfig

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh sparc x86"
IUSE="test"

DEPEND="virtual/libc
	test? ( >=dev-libs/check-0.8 )"

src_unpack() {
	hasq "maketest" ${FEATURES} && ! use test  && die "You must put makecheck into your USE if you have FEATURES=maketest"

	unpack ${A}
	cd "${S}"
	# Detect mips systems properly
	gnuconfig_update
}

src_install() {
	einstall man1dir="${D}/usr/share/man/man1" || die
	dodoc Changes README
	dohtml doc/
}
