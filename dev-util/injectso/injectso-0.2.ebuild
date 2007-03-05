# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/injectso/injectso-0.2.ebuild,v 1.10 2007/03/05 03:48:04 genone Exp $

inherit eutils

DESCRIPTION="Inject shared libraries into running processes under Solaris and Linux"
HOMEPAGE="http://www.securereality.com.au/"
SRC_URI="http://www.securereality.com.au/archives/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_install() {
	dobin injectso

	dodir /usr/lib/injectso
	insinto /usr/lib/injectso
	doins libtest.so libtest.c

	dodoc ChangeLog README.txt
	dohtml README.html
}

pkg_postinst() {
	echo
	elog "Read the documentation for instructions on how to use this tool."
	elog "The sample library \"libtest.so\" and its source file \"libtest.c\""
	elog "be found in /usr/lib/injectso."
	echo
}
