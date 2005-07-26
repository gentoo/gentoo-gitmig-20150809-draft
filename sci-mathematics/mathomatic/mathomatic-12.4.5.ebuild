# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-12.4.5.ebuild,v 1.1 2005/07/26 22:54:09 cryos Exp $

inherit eutils

DESCRIPTION="Automatic algebraic manipulator"
HOMEPAGE="http://www.mathomatic.com/"
SRC_URI="http://www.panix.com/~gesslein/${P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="icc"

DEPEND="sys-libs/readline
	sys-libs/ncurses
	icc? ( dev-lang/icc )"

src_compile() {
	if use icc; then
		CC="icc" CFLAGS="-O3 -axKWNBP -ipo" LDFLAGS="-O3 -axKWNBP -ipo -limf" emake || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	einstall || die "einstall failed."
	dodoc changes.txt README.txt

	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins tests/*in
	dohtml ${D}/usr/doc/mathomatic/*.htm
	rm -rf ${D}/usr/doc/mathomatic
}
